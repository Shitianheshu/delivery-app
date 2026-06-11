import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/app_assets.dart';
import '../../core/app_theme.dart';
import '../../widgets/app_widgets.dart';
import 'post_detail_screen.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  void _showRules(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ChatRulesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFFCE9DD),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.osakaHeaderBg, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, .5, 1],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      const Color(0xFFFFE9D6).withValues(alpha: .95),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    _ChatHeader(
                      onBack: () => Navigator.pop(context),
                      onInfo: () => _showRules(context),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                        children: [
                          ChatBubble(
                            name: 'たけたけ',
                            text: '梅田あたり\n鳴りやすい！',
                            time: '09:41',
                            avatarIndex: 0,
                            onTap:
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PostDetailScreen(),
                                  ),
                                ),
                          ),
                          const Center(
                            child: Text(
                              '09:42',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const ChatBubble(
                            name: 'あなた',
                            text: '今から天王寺\n向かいます！',
                            time: '',
                            mine: true,
                            withRider: true,
                          ),
                          const ChatBubble(
                            name: 'ユウキ',
                            text: '雨ふってきたね〜☔',
                            time: '09:43',
                            avatarIndex: 1,
                            blue: true,
                          ),
                          const Center(
                            child: Text(
                              '09:44',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const ChatBubble(
                            name: 'あなた',
                            text: '折りたたみ傘\n必須です☔',
                            time: '',
                            mine: true,
                          ),
                          const ChatBubble(
                            name: 'まつつー',
                            text: 'Uber多めですね〜',
                            time: '09:45',
                            avatarIndex: 2,
                            blue: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: const _ChatComposer(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.onBack, required this.onInfo});

  final VoidCallback onBack;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 22,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Text(
                  '関西エリア',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.users,
                      size: 11,
                      color: Color(0xFF6B6B6B),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '211人が参加中・今日の投稿 105件',
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onInfo,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Align(
                alignment: Alignment.centerRight,
                child: FaIcon(
                  FontAwesomeIcons.circleInfo,
                  size: 20,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .90),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: .40)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.fromLTRB(16, 0, 48, 0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF2F8).withValues(alpha: .60),
                    border: Border.all(color: const Color(0xFFFBCFE8)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: TextField(
                          maxLength: 10,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            hintText: '10文字以内でつぶやく...',
                            hintStyle: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 13),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Text(
                          '0/10',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE63946),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE63946).withValues(alpha: .25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.name,
    required this.text,
    required this.time,
    this.mine = false,
    this.avatarIndex = 0,
    this.blue = false,
    this.withRider = false,
    this.onTap,
  });
  final String name;
  final String text;
  final String time;
  final bool mine;
  final int avatarIndex;
  final bool blue;
  final bool withRider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bubble = GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxWidth: 230),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color:
                  mine
                      ? AppColors.primary
                      : (blue
                          ? const Color(0xFFDFF0FF)
                          : Colors.white.withValues(alpha: .94)),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(mine ? 18 : 4),
                bottomRight: Radius.circular(mine ? 4 : 18),
              ),
              boxShadow: softShadow(.09),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.35,
                    color: mine ? Colors.white : AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (withRider) ...[
                  const SizedBox(width: 8),
                  Image.asset(AppAssets.riderSide, width: 42),
                ],
              ],
            ),
          ),
          if (time.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine) ...[
            AvatarCircle(size: 40, index: avatarIndex),
            const SizedBox(width: 8),
          ],
          bubble,
        ],
      ),
    );
  }
}

class ChatRulesScreen extends StatelessWidget {
  const ChatRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2FE), Colors.white, Color(0xFFFDF2F8)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  _RulesHeader(onBack: () => Navigator.pop(context)),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                      child: _RulesCard(onDone: () => Navigator.pop(context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RulesHeader extends StatelessWidget {
  const _RulesHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 22,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'つぶやきのルール',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const _TenCharacterBadge(),
          const SizedBox(height: 24),
          const Text(
            '10文字以内で投稿してください',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 24),
          const Column(
            children: [
              _RuleItem('10文字以内で投稿してください'),
              SizedBox(height: 12),
              _RuleItem('誹謗中傷・スパムは禁止です'),
              SizedBox(height: 12),
              _RuleItem('個人情報は書き込まないでください'),
              SizedBox(height: 12),
              _RuleItem('みんなで気持ちよく使いましょう'),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFE63946),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE63946).withValues(alpha: .22),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onDone,
                  borderRadius: BorderRadius.circular(16),
                  child: const Center(
                    child: Text(
                      'わかりました',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TenCharacterBadge extends StatelessWidget {
  const _TenCharacterBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 132,
        width: 132,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFCE7F3), Color(0xFFFEF2F2)],
                ),
              ),
              child: const Center(
                child: Text(
                  '10',
                  style: TextStyle(
                    color: Color(0xFFE63946),
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE63946),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '文字',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  const _RuleItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: FaIcon(
            FontAwesomeIcons.circleCheck,
            size: 16,
            color: Color(0xFFE63946),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
