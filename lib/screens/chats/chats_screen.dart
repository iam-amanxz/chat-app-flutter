import '../messages/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              final participants = [
                currentUser,
                const User(
                  id: '05b9c31b-0f57-4863-bbfc-3ea6c0e67c17',
                  email: 'doe@mail.com',
                  name: 'John Doe',
                  username: 'doemans',
                )
              ];

              context
                  .read<ChatsBloc>()
                  .add(ChatsCreate(participants: participants));
            },
            child: const Text('Add New Chat'),
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
          final friend =
              chat.participants.firstWhere((user) => user.id != currentUser.id);
          return InkWell(
            onTap: () {
              // create chat if not exists
              // set current chat
              // final chats = ref.read(chatsServiceProvider);
              // List<User> participants = [currentUser, friend];
              // chats.createChat(participants);

              showChatView(
                context,
                friend,
                chat,
                ref,
                _listController,
                _messageController,
                _form,
              );
              // open chat view
              // showModalBottomSheet(
              //   backgroundColor: Colors.black,
              //   isScrollControlled: true,
              //   context: context,
              //   builder: (context) {
              //     return MediaQuery(
              //       data: MediaQueryData.fromWindow(
              //           WidgetsBinding.instance.window),
              //       child: SafeArea(
              //         child: Column(
              //           children: [
              //             Row(
              //               children: [
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                   icon: const Icon(
              //                     Icons.arrow_back_ios,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: ListTile(
              //                     leading: CircleAvatar(
              //                       backgroundColor: Colors.white,
              //                       child: Text(
              //                         friend.name.substring(0, 1),
              //                         style: const TextStyle(
              //                           fontSize: 20,
              //                           color: Colors.black,
              //                         ),
              //                       ),
              //                     ),
              //                     title: Text(
              //                       friend.name,
              //                       style: const TextStyle(
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                     subtitle: Text(
              //                       friend.username,
              //                       style: const TextStyle(
              //                         color: Colors.white38,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Expanded(
              //               child: Stack(
              //                 children: [
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                       bottom: MediaQuery.of(context)
              //                               .viewInsets
              //                               .bottom +
              //                           60,
              //                     ),
              //                     child: StreamBuilder<List<Message>>(

              //                         // stream: ref
              //                         //     .watch(messageServiceProvider)
              //                         //     .messagesSub(chat.id),
              //                         stream: ref
              //                             .watch(messageServiceProvider)
              //                             .stream(chat.id)
              //                             .map((json) {
              //                           print(json);
              //                           List<Message> messages = [];
              //                           for (var item in json.docs) {
              //                             messages.add(
              //                               Message.fromJson(item.data()),
              //                             );
              //                           }
              //                           return messages;
              //                         }),
              //                         builder: (context, snapshot) {
              //                           if (snapshot.hasData) {
              //                             final List<Message> messages =
              //                                 snapshot.requireData;
              //                             return ListView.builder(
              //                               reverse: true,
              //                               shrinkWrap: true,
              //                               controller: _listController,
              //                               itemBuilder: (context, index) =>
              //                                   Container(
              //                                 padding: const EdgeInsets.only(
              //                                   left: 10,
              //                                   right: 10,
              //                                   top: 7,
              //                                   bottom: 7,
              //                                 ),
              //                                 child: Align(
              //                                   alignment:
              //                                       messages[index].senderId !=
              //                                               currentUser.id
              //                                           ? Alignment.topLeft
              //                                           : Alignment.topRight,
              //                                   child: Container(
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               100),
              //                                       color: messages[index]
              //                                                   .senderId !=
              //                                               currentUser.id
              //                                           ? Colors.white24
              //                                           : Colors.green.shade700,
              //                                     ),
              //                                     padding: const EdgeInsets
              //                                         .symmetric(
              //                                       horizontal: 16,
              //                                       vertical: 10,
              //                                     ),
              //                                     child: Text(
              //                                       messages[index].content,
              //                                       style: const TextStyle(
              //                                         fontSize: 14,
              //                                         color: Colors.white,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               itemCount: messages.length,
              //                             );
              //                           }
              //                           if (snapshot.hasError) {
              //                             print(snapshot.error);
              //                             return const Text(
              //                               'Oops! Something went wrong.',
              //                               textAlign: TextAlign.center,
              //                               style:
              //                                   TextStyle(color: Colors.white),
              //                             );
              //                           }
              //                           return const SizedBox();
              //                         }),
              //                   ),
              //                   Align(
              //                     alignment: Alignment.bottomLeft,
              //                     child: Container(
              //                       color: Colors.black,
              //                       child: Padding(
              //                         padding: EdgeInsets.only(
              //                           bottom: MediaQuery.of(context)
              //                                   .viewInsets
              //                                   .bottom +
              //                               10,
              //                         ),
              //                         child: Row(
              //                           children: [
              //                             Expanded(
              //                               child: Form(
              //                                 key: _form,
              //                                 child: TextFormField(
              //                                   controller: _messageController,
              //                                   textInputAction:
              //                                       TextInputAction.next,
              //                                   onChanged: (value) {
              //                                     if (value.isEmpty) {
              //                                       return;
              //                                     }
              //                                     _form.currentState!.save();
              //                                   },
              //                                   style: const TextStyle(
              //                                     fontSize: 14,
              //                                     color: Colors.white,
              //                                   ),
              //                                   decoration: InputDecoration(
              //                                     filled: true,
              //                                     fillColor: Colors.white10,
              //                                     contentPadding:
              //                                         const EdgeInsets
              //                                             .symmetric(
              //                                       horizontal: 15,
              //                                     ),
              //                                     enabledBorder:
              //                                         OutlineInputBorder(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               12.0),
              //                                     ),
              //                                     focusedBorder:
              //                                         OutlineInputBorder(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               12.0),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                             IconButton(
              //                               splashColor: Colors.white10,
              //                               onPressed: () {
              //                                 _onSend(chat);
              //                               },
              //                               icon: const Icon(
              //                                 Icons.send,
              //                                 color: Colors.white,
              //                               ),
              //                               disabledColor: Colors.white30,
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
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

  void _onSend(Chat chat) {
    if (_messageController.text.isEmpty) {
      return;
    }
    final message = Message.toDb(
      chatId: chat.id,
      content: _messageController.text,
      senderId: currentUser.id,
    );
    print(message);
    context.read<MessagesBloc>().add(MessageSend(message: message));
    _messageController.clear();
    _messageController.text = '';
    _listController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
