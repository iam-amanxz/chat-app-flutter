import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../di.dart';
import '../../main.dart';
import '../../models/chat/chat.dart';
import '../../models/message/message.dart';
import '../../models/user/user.dart';
import '../messages/bloc/messages_bloc.dart';
import '../widgets/page_title.dart';
import 'bloc/chats_bloc.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(label: 'Chats'),
          const SizedBox(height: 15),
          _buildSearch(context),
          const SizedBox(height: 15),
          StreamBuilder<List<Chat>>(
            stream: ref.watch(chatsServiceProvider).stream.map((json) {
              List<Chat> chats = [];
              for (var item in json.docs) {
                chats.add(
                  Chat.fromJson(item.data()),
                );
              }
              return chats;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Chat> chats = snapshot.requireData;
                return _buildChatsList(ref, chats);
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

  Widget _buildChatsList(WidgetRef ref, List<Chat> chats) {
    return Expanded(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final friend = chat.participants.firstWhere(
              (user) => user.id != ref.watch(currentUserProvider).id);
          return InkWell(
            onTap: () {
              // create chat if not exists
              // set current chat
              // final chats = ref.read(chatsServiceProvider);
              // List<User> participants = [currentUser, friend];
              // chats.createChat(participants);
              GoRouter.of(context)
                  .push('/chat', extra: {"friend": friend, "chat": chat});
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
              // subtitle: Text(
              //   chat.messages.isNotEmpty ? chat.messages.last.content : '',
              //   style: const TextStyle(color: Colors.white38),
              // ),
              // trailing: Text(
              //   chat.messages.isNotEmpty
              //       ? chat.messages.last.formattedCreatedAt()
              //       : '',
              //   style: const TextStyle(color: Colors.white38),
              // ),
            ),
          );
        },
      ),
    );
  }
}
