import 'package:flutter/material.dart';

import '../widgets/app_widgets.dart';
import 'friends/friends_screen.dart';
import 'profile/profile_screen.dart';
import 'region/region_selection_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const RegionSelectionScreen(showBottomNav: false),
      const FriendsScreen(showBottomNav: false),
      const ProfileScreen(showBottomNav: false),
    ];
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNav(
        index: _index,
        onTap: (value) => setState(() => _index = value),
      ),
    );
  }
}
