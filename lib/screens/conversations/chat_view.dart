import '../../common/styles/form_styles.dart';
import '../../config/di.dart';
import '../../features/contact/model/contact.dart';
import '../../features/conversation/bloc/conversation_bloc.dart';
import '../../features/message/bloc/message_bloc.dart';
import '../../features/message/dto/send_message_dto.dart';
import '../../features/message/messages_state_provider.dart';
import '../../features/message/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/text_styles.dart';
import '../../features/auth/current_user_state.dart';
import '../../features/contact/bloc/contact_bloc.dart';
import '../../features/contact/bloc/contacts_state_provider.dart';
import '../../common/extensions/is_dark_mode.dart';

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
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            ),
          );
        },
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  late Stream<List<Message>> stream;
  List<Message> currentMessageList = [];

  @override
  void initState() {
    super.initState();

    stream = ref.read(messageProvider).getMessages(widget.conversationId);

    stream.listen((newMessages) {
      final List<Message> messageList = newMessages;

      if (_listKey.currentState != null &&
          _listKey.currentState!.widget.initialItemCount < messageList.length) {
        List<Message> updateList =
            messageList.where((e) => !currentMessageList.contains(e)).toList();

        for (var update in updateList) {
          final int updateIndex = messageList.indexOf(update);
          _listKey.currentState?.insertItem(updateIndex);
        }
      }

      currentMessageList = messageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Message>>(
        stream: stream,
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

            return AnimatedList(
              key: _listKey,
              physics: const BouncingScrollPhysics(),
              reverse: true,
              initialItemCount: messages.length,
              itemBuilder: (context, index, animation) {
                final message = messages[index];
                return SlideTransition(
                  position: animation.drive(_offset),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 7,
                      bottom: 7,
                    ),
                    child: Align(
                      alignment: message.senderId !=
                              ref.watch(currentUserState).value!.id
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: message.senderId !=
                                  ref.watch(currentUserState).value!.id
                              ? context.isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200
                              : context.isDarkMode
                                  ? Colors.green.shade700
                                  : Colors.deepPurple,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: message.senderId !=
                                    ref.watch(currentUserState).value!.id
                                ? context.isDarkMode
                                    ? Colors.white
                                    : Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

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
              style: TextStyle(
                fontSize: 18.0,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                fillColor: context.isDarkMode
                    ? Colors.grey.shade900
                    : Colors.grey.shade300,
                enabledBorder: OutlineInputBorder(
                  borderSide: context.isDarkMode
                      ? const BorderSide(color: Colors.black)
                      : const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: context.isDarkMode
                      ? const BorderSide(color: Colors.black)
                      : const BorderSide(color: Colors.white),
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
                  icon: Icon(
                    Icons.send,
                    color:
                        context.isDarkMode ? Colors.white : Colors.deepPurple,
                  ),
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
            ),
            title: Text(
              friend.username,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}
