import '../../di.dart';
import '../../main.dart';
import '../../models/chat/chat.dart';
import '../../models/message/message.dart';
import '../../models/user/user.dart';
import 'bloc/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> showChatView(
  BuildContext context,
  User friend,
  Chat chat,
  WidgetRef ref,
  ScrollController scrollController,
  TextEditingController messageController,
  GlobalKey<FormState> formKey,
) {
  void _onSend(Chat chat) {
    if (messageController.text.isEmpty) {
      return;
    }
    final message = Message.toDb(
      chatId: chat.id,
      content: messageController.text,
      senderId: currentUser.id,
    );
    print(message);
    context.read<MessagesBloc>().add(MessageSend(message: message));
    messageController.clear();
    messageController.text = '';
    scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  return showModalBottomSheet(
    backgroundColor: Colors.black,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: SafeArea(
          child: Column(
            children: [
              Row(
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
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 60,
                      ),
                      child: StreamBuilder<List<Message>>(
                          stream: ref
                              .watch(messageServiceProvider)
                              .stream(chat.id)
                              .map((json) {
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
                              final List<Message> messages =
                                  snapshot.requireData;
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
                                    alignment: messages[index].senderId !=
                                            currentUser.id
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: messages[index].senderId !=
                                                currentUser.id
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
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Form(
                                  key: formKey,
                                  child: TextFormField(
                                    controller: messageController,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                splashColor: Colors.white10,
                                onPressed: () {
                                  _onSend(chat);
                                },
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
