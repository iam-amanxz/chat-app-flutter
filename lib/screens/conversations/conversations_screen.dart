import 'package:chat_app/config/di.dart';
import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:chat_app/features/contact/bloc/contact_bloc.dart';
import 'package:chat_app/features/conversation/model/conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/text_styles.dart';
import '../../features/conversation/bloc/conversation_bloc.dart';
import '../../features/conversation/bloc/conversations_state_provider.dart';
import '../../common/extensions/message.dart';

class ConversationsScreen extends ConsumerStatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConversationsScreen> createState() =>
      _ConversationsScreenState();
}

class _ConversationsScreenState extends ConsumerState<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().loadContacts();
    context.read<ConversationBloc>().loadConversations();
  }

  @override
  Widget build(BuildContext context) {
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

          StreamBuilder<List<Conversation>>(
            stream: ref.read(conversationProvider).myConversations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text(
                  'Oops! something went wrong!',
                  style: TextStyle(color: Colors.white),
                );
              }
              if (snapshot.hasData) {
                final conversations = snapshot.requireData;
                return Expanded(
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: ((context, index) {
                      final conversation = conversations[index];
                      final friend = conversation.participants.firstWhere(
                          (p) => p.id != ref.read(currentUserState).value!.id);
                      return InkWell(
                        onTap: () {
                          final conversationId = conversation.id;

                          GoRouter.of(context).push(
                            '/app/conversations/$conversationId',
                            extra: {"friend": friend},
                          );
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(friend.photoUrl!),
                          ),
                          title: Text(
                            friend.username,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            conversation.lastMessage?.content ?? '',
                            style: const TextStyle(color: Colors.white38),
                          ),
                          trailing: Text(
                            conversation.lastMessage?.formattedCreatedAt() ??
                                '',
                            style: const TextStyle(color: Colors.white38),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
