import 'package:chat_app/di.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/message/message.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:chat_app/screens/messages/bloc/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../chats/bloc/chats_bloc.dart';

class MessageScreen extends ConsumerStatefulWidget {
  final GoRouterState state;
  const MessageScreen({Key? key, required this.state}) : super(key: key);

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  late final TextEditingController _textController;
  late final ScrollController _listController;
  final _form = GlobalKey<FormState>();
  late final User? friend;
  late final Chat? chat;
  late final Map<String, dynamic> extras;

  @override
  void initState() {
    extras = widget.state.extra! as Map<String, dynamic>;
    if (extras["chat"] == null) {
      context.read<ChatsBloc>().add(
            GetChatByParticipants(
              participants: [extras["friend"], currentUser],
            ),
          );
    }

    _textController = TextEditingController();
    _listController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: extras["chat"] == null
              ? BlocBuilder<ChatsBloc, ChatsState>(
                  builder: (context, state) {
                    return state.when(
                      started: () => const SizedBox(),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) =>
                          Text(message ?? 'Oops, something went wrong!'),
                      success: (chat) => _buildChat(chat),
                    );
                  },
                )
              : _buildChat(null),
        ),
      ),
    );
  }

  Widget _buildChat(Chat? chat) {
    return Column(
      children: [
        ChatHeader(friend: extras["friend"]),
        Expanded(
          child: Stack(
            children: [
              ChatView(
                context: context,
                chat: chat ?? extras["chat"],
                ref: ref,
                scrollController: _listController,
              ),
              ChatSendForm(
                  controller: _textController,
                  formKey: _form,
                  onSend: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    final message = Message.toDb(
                      chatId: chat != null ? chat.id : extras["chat"].id,
                      content: _textController.text,
                      senderId: currentUser.id,
                    );
                    context
                        .read<MessagesBloc>()
                        .add(MessageSend(message: message));
                    _textController.clear();
                    _textController.text = '';
                    _listController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatView extends StatelessWidget {
  final Chat chat;
  final WidgetRef ref;
  final ScrollController scrollController;
  const ChatView({
    Key? key,
    required this.context,
    required this.chat,
    required this.ref,
    required this.scrollController,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 60,
      ),
      child: StreamBuilder<List<Message>>(
          stream: ref.watch(messageServiceProvider).stream(chat.id).map((json) {
            List<Message> messages = [];
            for (var item in json.docs) {
              messages.add(
                Message.fromJson(item.data()),
              );
            }
            return messages;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Message> messages = snapshot.requireData;
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 7,
                    bottom: 7,
                  ),
                  child: Align(
                    alignment: messages[index].senderId != currentUser.id
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: messages[index].senderId != currentUser.id
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
                ),
                itemCount: messages.length,
              );
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
          }),
    );
  }
}

class ChatSendForm extends StatelessWidget {
  final Function onSend;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  const ChatSendForm({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        return;
                      }
                      formKey.currentState!.save();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                splashColor: Colors.white10,
                onPressed: () => onSend(),
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                disabledColor: Colors.white30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  final User friend;
  const ChatHeader({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Expanded(
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
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              friend.username,
              style: const TextStyle(
                color: Colors.white38,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
