import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:chat_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/auth_state.dart';

class AppRootScreen extends ConsumerStatefulWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  AuthRequiredState<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends AuthRequiredState<AppRootScreen> {
  int _selectedIndex = 1;
  late final PageController _pageController;

  final List<Widget> _screens = const [
    Text('Hello'),
    ProfileScreen(),
  ];

  static const _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Hello',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        items: _navItems,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
      ),
    );
  }
}
