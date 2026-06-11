import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/dummy_data.dart';
import '../../widgets/app_widgets.dart';
import '../chat/chat_room_screen.dart';

const _friendsRed = Color(0xFFE63946);
const _friendsText = Color(0xFF2D2D2D);
const _friendsMuted = Color(0xFF999999);
const _friendsBorder = Color(0xFFE0DCD5);
const _friendsTabBorder = Color(0xFFF0EBE3);

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key, this.showBottomNav = true});
  final bool showBottomNav;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final visibleFriends =
        _selectedTab == 0 ? friends : friends.take(2).toList();

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8FAFF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0F9FF), Colors.white],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  const _FriendsHeader(),
                  Row(
                    children: [
                      Expanded(
                        child: _FriendTab(
                          label: 'フレンド一覧',
                          count: '12',
                          selected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      Expanded(
                        child: _FriendTab(
                          label: '承認待ち',
                          count: '2',
                          selected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: _FriendSearchField(),
                  ),
                  Expanded(
                    child:
                        visibleFriends.isEmpty
                            ? Center(
                              child: Text(
                                _selectedTab == 0 ? 'フレンドがいません' : '承認待ちはありません',
                                style: const TextStyle(
                                  color: _friendsMuted,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                16,
                                16,
                                150,
                              ),
                              itemCount: visibleFriends.length,
                              separatorBuilder:
                                  (_, _) => const SizedBox(height: 8),
                              itemBuilder:
                                  (context, index) => FriendRow(
                                    friend: visibleFriends[index],
                                    pending: _selectedTab == 1,
                                    onTap:
                                        () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const ChatRoomScreen(),
                                          ),
                                        ),
                                  ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: widget.showBottomNav ? 74 : 8),
        child: const _AddFriendButton(),
      ),
      bottomNavigationBar:
          widget.showBottomNav ? AppBottomNav(index: 1, onTap: (_) {}) : null,
    );
  }
}

class _FriendsHeader extends StatelessWidget {
  const _FriendsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          SizedBox(width: 26),
          Expanded(
            child: Center(
              child: Text(
                'フレンド一覧',
                style: TextStyle(
                  color: _friendsText,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          FaIcon(FontAwesomeIcons.userPlus, color: _friendsText, size: 20),
        ],
      ),
    );
  }
}

class _FriendTab extends StatelessWidget {
  const _FriendTab({
    required this.label,
    required this.count,
    required this.onTap,
    this.selected = false,
  });
  final String label;
  final String count;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _friendsTabBorder)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: selected ? _friendsRed : _friendsMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? _friendsRed : _friendsTabBorder,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      count,
                      style: TextStyle(
                        color: selected ? Colors.white : _friendsMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                margin: const EdgeInsets.only(top: 8),
                height: 2,
                width: selected ? 48 : 0,
                decoration: BoxDecoration(
                  color: _friendsRed,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendSearchField extends StatelessWidget {
  const _FriendSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _friendsBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: 16,
            color: _friendsMuted,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ニックネーム',
                hintStyle: TextStyle(
                  color: _friendsMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddFriendButton extends StatelessWidget {
  const _AddFriendButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: _friendsRed,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: _friendsRed.withValues(alpha: .30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.userPlus, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'フレンドを追加する',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class FriendRow extends StatelessWidget {
  const FriendRow({
    super.key,
    required this.friend,
    required this.onTap,
    this.pending = false,
  });
  final FriendInfo friend;
  final VoidCallback onTap;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF1ECE5)),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AvatarCircle(index: friend.avatarIndex),
                  StatusDot(online: friend.online),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend.name,
                      style: const TextStyle(
                        color: _friendsText,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      friend.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color:
                            friend.online
                                ? const Color(0xFF22C55E)
                                : _friendsMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pending ? '承認待ちです' : friend.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: FaIcon(
                  pending
                      ? FontAwesomeIcons.userPlus
                      : FontAwesomeIcons.message,
                  color: _friendsText,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
