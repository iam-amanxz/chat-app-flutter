import 'dart:async';

import 'package:chat_app/screens/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di.dart';
import '../../main.dart';
import '../../models/user/user.dart';
import 'bloc/friends_bloc.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  initState() {
    context.read<FriendsBloc>().add(FriendsStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(label: 'Friends'),
          const SizedBox(height: 15),
          _buildSearch(context),
          const SizedBox(height: 15),
          BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              return state.when(
                started: () => const SizedBox(),
                loading: () => const Text('Loading...'),
                error: () => const Text('Error'),
                success: (friends) => _buildFriendsList(ref, friends),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

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

Widget _buildFriendsList(WidgetRef ref, Stream<List<User>> friends) {
  return StreamBuilder<List<User>>(
      stream: friends,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final friends = snapshot.requireData;
          friends.removeWhere((element) => element.id == currentUser.id);
          return Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return InkWell(
                  onTap: () {
                    print('tapped');
                    final chats = ref.read(chatsProvider);
                    List<User> participants = [currentUser, friend];

                    chats.createChat(participants);
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
                      friend.username,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      friend.email,
                      style: const TextStyle(color: Colors.white38),
                    ),
                  ),
                );
              },
            ),
          );
        }
        if (snapshot.hasError) {
          return const Text('Error');
        }
        return const SizedBox();
      });
}
