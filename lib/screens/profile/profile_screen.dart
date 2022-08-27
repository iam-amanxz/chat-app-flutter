import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/styles/form_styles.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/current_user_state.dart';
import '../../features/contact/model/contact.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  Contact? _currentUser;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ref.watch(currentUserState).when(data: (Contact? user) {
          if (user == null) {
            GoRouter.of(context).go('/auth');
            return Container();
          }

          setState(() {
            _currentUser = user;
            _nameController.text = user.name ?? '';
            _aboutController.text = user.about ?? '';
          });

          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                loading: () => setState(() {
                  _isLoading = true;
                }),
                orElse: () => setState(() {
                  _isLoading = false;
                }),
              );
            },
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().signOut();
                    },
                    icon: const Icon(Icons.power_settings_new),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 55.0,
                    child: !_isLoading
                        ? Image.network(
                            user.photoUrl!,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text('Error Loading'),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
                !_isLoading
                    ? TextButton(
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then((image) {
                            if (image != null) {
                              context
                                  .read<AuthBloc>()
                                  .updateProfilePhoto(image);
                            }
                          });
                        },
                        child: const Text('Edit'),
                      )
                    : Container(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: formInputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _aboutController,
                        decoration: formInputDecoration(labelText: 'About'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }, error: (Object error, StackTrace? stackTrace) {
          setState(() {
            _isLoading = false;
          });
          return Center(child: Text(error.toString()));
        }, loading: () {
          setState(() {
            _isLoading = true;
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
      floatingActionButton: !_isLoading
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                if (_currentUser == null) {
                  return;
                }
                final user = Contact(
                  id: _currentUser!.id,
                  username: _currentUser!.username,
                  name: _nameController.text,
                  about: _aboutController.text,
                  photoUrl: _currentUser!.photoUrl,
                );
                context.read<AuthBloc>().updateCurrentUser(user);
                FocusScope.of(context).unfocus();
              },
              child: const Icon(Icons.save),
            )
          : Container(),
    );
  }
}
