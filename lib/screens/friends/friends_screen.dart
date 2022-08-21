import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../di.dart';
import '../../models/user/user.dart';
import '../widgets/page_title.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _messageController;
  late final ScrollController _listController;
  final _form = GlobalKey<FormState>();

  @override
  initState() {
    _messageController = TextEditingController();
    _listController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(label: 'Friends'),
          const SizedBox(height: 15),
          _buildSearch(context),
          const SizedBox(height: 15),
          StreamBuilder<List<User>>(
            stream: ref.watch(friendServiceProvider).stream.map((json) {
              List<User> friends = [];
              for (var item in json.docs) {
                friends.add(
                  User.fromJson(item.data()),
                );
              }
              return friends;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<User> friends = snapshot.requireData;
                friends.removeWhere(
                    (friend) => friend.id == ref.watch(currentUserProvider).id);
                return _buildFriendsList(context, ref, friends);
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text(
                  'Oops! Something went wrong.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                );
              }
              return const SizedBox();
            },
          ),
          TextButton(
              onPressed: () {
                final user = ref.watch(currentUserProvider);
                user == authUser1
                    ? ref.read(currentUserProvider.notifier).state = authUser2
                    : ref.read(currentUserProvider.notifier).state = authUser1;
              },
              child: const Text(
                'Change User',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildSearch(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.circular(100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          labelText: 'Search',
          labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsList(
      BuildContext context, WidgetRef ref, List<User> friends) {
    return Expanded(
      child: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return InkWell(
            onTap: () async {
              GoRouter.of(context)
                  .push('/chat', extra: {"friend": friend, "chat": null});

              return;
              // List<User> participants = [currentUser, friend];
              // context
              //     .read<ChatsBloc>()
              //     .add(ChatsCreate(participants: participants));

              // ref
              //     .read(chatsServiceProvider)
              //     .getChatByParticipants(
              //       participants,
              //     )
              //     .then((chat) {
              //   if (chat != null) {
              //     showChatView(
              //       context,
              //       friend,
              //       chat,
              //       ref,
              //       _listController,
              //       _messageController,
              //       _form,
              //     );
              //   }
              // });
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  friend.name.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Text(
                friend.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                friend.email,
                style: const TextStyle(color: Colors.white38),
              ),
            ),
          );
        },
      ),
    );
  }
}
