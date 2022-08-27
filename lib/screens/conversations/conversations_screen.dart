import 'package:chat_app/features/contact/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/text_styles.dart';
import '../../features/conversation/bloc/conversation_bloc.dart';
import '../../features/conversation/bloc/conversations_state_provider.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().loadContacts();
    context.read<ConversationBloc>().loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
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
                    'Conversations',
                    style: titleStyle(),
                  ),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).push('/app/contacts');
                    },
                    icon: const Icon(Icons.add_circle_outline_sharp),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // search bar

              // list of contacts
              state.when(
                idle: () => Container(),
                error: (e) => Text(
                  e.description,
                  style: const TextStyle(color: Colors.white),
                ),
                loading: () => const CircularProgressIndicator(),
                success: () {
                  return Consumer(
                    builder: ((context, ref, child) {
                      return ref.watch(conversationsState).when(
                          data: (conversations) {
                            if (conversations.isEmpty) {
                              return const Text(
                                'Woah... such empty!\nCreate a conversation by clicking on the plus icon',
                                style: TextStyle(color: Colors.white),
                              );
                            }
                            return Expanded(
                              child: ListView.builder(
                                itemCount: conversations.length,
                                itemBuilder: ((context, index) {
                                  final conversation = conversations[index];
                                  return InkWell(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      leading: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          'HA',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        conversation.id,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'How are you?',
                                        style: const TextStyle(
                                            color: Colors.white38),
                                      ),
                                      trailing: Text(
                                        '16:31',
                                        style: const TextStyle(
                                            color: Colors.white38),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                          error: (e, s) => Text(e.toString()),
                          loading: () => const CircularProgressIndicator());
                    }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
