import 'package:chat_app/common/styles/text_styles.dart';
import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:chat_app/features/contact/bloc/contact_bloc.dart';
import 'package:chat_app/features/contact/bloc/contacts_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black,
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contacts',
                        style: titleStyle(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sync),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 1,
                    child: state.when(
                      idle: () => Container(),
                      error: (e) => Text(
                        e.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      success: () {
                        return Consumer(
                          builder: ((context, ref, child) {
                            return ref.watch(contactsState).when(
                                error: (e, s) => Text(e.toString()),
                                loading: () =>
                                    const CircularProgressIndicator(),
                                data: (contacts) {
                                  contacts.removeWhere((user) =>
                                      user.id ==
                                      ref.read(currentUserState).value!.id);
                                  return ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: contacts.length,
                                    itemBuilder: ((context, index) {
                                      final contact = contacts[index];
                                      return InkWell(
                                        onTap: () {},
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(contact.photoUrl!),
                                            radius: 25.0,
                                            backgroundColor: Colors.white,
                                          ),
                                          title: Text(
                                            contact.username,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                });
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
