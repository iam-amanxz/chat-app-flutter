import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/current_user_state.dart';
import '../../features/contact/bloc/contact_bloc.dart';
import '../../features/contact/bloc/contacts_state_provider.dart';
import '../../features/conversation/bloc/conversation_bloc.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
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
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ContactBloc>().loadContacts();
                        },
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
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
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
                                        onTap: () {
                                          final participants = [
                                            contact,
                                            ref.read(currentUserState).value!
                                          ];
                                          context
                                              .read<ConversationBloc>()
                                              .createConversation(
                                                participants,
                                              );
                                          GoRouter.of(context).pop();
                                        },
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
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
            ),
          );
        },
      ),
    );
  }
}
