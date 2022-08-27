import 'package:chat_app/common/styles/form_styles.dart';
import 'package:chat_app/config/di.dart';
import 'package:chat_app/features/contact/model/contact.dart';
import 'package:chat_app/features/conversation/bloc/conversation_bloc.dart';
import 'package:chat_app/features/message/bloc/message_bloc.dart';
import 'package:chat_app/features/message/dto/send_message_dto.dart';
import 'package:chat_app/features/message/messages_state_provider.dart';
import 'package:chat_app/features/message/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/text_styles.dart';
import '../../features/auth/current_user_state.dart';
import '../../features/contact/bloc/contact_bloc.dart';
import '../../features/contact/bloc/contacts_state_provider.dart';

class ChatView extends StatefulWidget {
  final String conversationId;
  final Contact friend;
  const ChatView({Key? key, required this.conversationId, required this.friend})
      : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().loadMessages(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black,
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChatHeader(friend: widget.friend),
                  MessagesList(conversationId: widget.conversationId),
                  ChatSenderForm(
                      conversationId: widget.conversationId,
                      receiverId: widget.friend.id)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MessagesList extends ConsumerStatefulWidget {
  final String conversationId;
  const MessagesList({Key? key, required this.conversationId})
      : super(key: key);

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: StreamBuilder<List<Message>>(
          stream: ref.read(messageProvider).getMessages(widget.conversationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            if (snapshot.hasError) {
              return const Text(
                'Oops! something went wrong!',
                style: TextStyle(color: Colors.white),
              );
            }

            if (snapshot.hasData) {
              final messages = snapshot.requireData;

              return ListView.builder(
                  itemCount: messages.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 7,
                        bottom: 7,
                      ),
                      child: Align(
                        alignment: messages[index].senderId !=
                                ref.watch(currentUserState).value!.id
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: messages[index].senderId !=
                                    ref.watch(currentUserState).value!.id
                                ? Colors.white24
                                : Colors.green.shade700,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Text(
                            messages[index].content,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
// class MessagesList extends ConsumerWidget {
//   final String conversationId;
//   const MessagesList({Key? key, required this.conversationId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15.0),
//         child: StreamBuilder<List<Message>>(
//           stream: ref.read(messageProvider).getMessages(conversationId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Container();
//             }
//             if (snapshot.hasError) {
//               return const Text(
//                 'Oops! something went wrong!',
//                 style: TextStyle(color: Colors.white),
//               );
//             }

//             if (snapshot.hasData) {
//               final messages = snapshot.requireData;
//               return ListView.builder(
//                   itemCount: messages.length,
//                   reverse: true,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       padding: const EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                         top: 7,
//                         bottom: 7,
//                       ),
//                       child: Align(
//                         alignment: messages[index].senderId !=
//                                 ref.watch(currentUserState).value!.id
//                             ? Alignment.topLeft
//                             : Alignment.topRight,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: messages[index].senderId !=
//                                     ref.watch(currentUserState).value!.id
//                                 ? Colors.white24
//                                 : Colors.green.shade700,
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           child: Text(
//                             messages[index].content,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   });
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

class ChatSenderForm extends StatefulWidget {
  final String conversationId;
  final String receiverId;
  const ChatSenderForm(
      {Key? key, required this.conversationId, required this.receiverId})
      : super(key: key);

  @override
  State<ChatSenderForm> createState() => _ChatSenderFormState();
}

class _ChatSenderFormState extends State<ChatSenderForm> {
  bool _isFormValid = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (text) {
                if (text.trim().isNotEmpty) {
                  setState(() {
                    _isFormValid = true;
                  });
                } else {
                  setState(() {
                    _isFormValid = false;
                  });
                }
              },
              controller: _controller,
              style: const TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          _isFormValid
              ? IconButton(
                  onPressed: () {
                    context.read<MessageBloc>().sendMessage(
                          SendMessageDto(
                            content: _controller.text.trim(),
                            conversationId: widget.conversationId,
                            receiverId: widget.receiverId,
                          ),
                        );

                    _controller.clear();
                    setState(() {
                      _isFormValid = false;
                    });
                  },
                  icon: const Icon(Icons.send),
                )
              : Container()
        ],
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  final Contact friend;
  const ChatHeader({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend.photoUrl!),
              radius: 25.0,
              backgroundColor: Colors.white,
            ),
            title: Text(
              friend.username,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
