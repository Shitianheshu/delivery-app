import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _bg = Color(0xFFF5F0E8);
  static const _text = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF6B6B6B);
  static const _primary = Color(0xFFE63946);
  static const _divider = Color(0xFFF0EBE3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                _SettingsHeader(onBack: () => Navigator.pop(context)),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      children: [
                        const _SettingsGroup(
                          children: [
                            _LanguageRow(),
                            _SettingsDivider(),
                            _SettingsRow(
                              label: '通知設定',
                              icon: FontAwesomeIcons.bell,
                            ),
                            _SettingsDivider(),
                            _SettingsRow(
                              label: '通報・ブロック履歴',
                              icon: FontAwesomeIcons.shieldHalved,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const _PremiumPlanCard(),
                        const SizedBox(height: 12),
                        const _SettingsGroup(
                          children: [
                            _SettingsRow(
                              label: '利用規約',
                              icon: FontAwesomeIcons.fileLines,
                            ),
                            _SettingsDivider(),
                            _SettingsRow(
                              label: 'プライバシーポリシー',
                              icon: FontAwesomeIcons.shield,
                            ),
                            _SettingsDivider(),
                            _SettingsRow(
                              label: 'ヘルプ・お問い合わせ',
                              icon: FontAwesomeIcons.circleQuestion,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _LogoutButton(
                          onTap:
                              () => Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  color: SettingsScreen._text,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                '設定',
                style: TextStyle(
                  color: SettingsScreen._text,
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

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow();

  @override
  Widget build(BuildContext context) {
    return const _SettingsButton(
      left: Text(
        '言語設定',
        style: TextStyle(
          color: SettingsScreen._text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      right: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RedDot(),
          SizedBox(width: 8),
          Text(
            '日本語',
            style: TextStyle(
              color: SettingsScreen._primary,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 8),
          _ChevronRight(),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.label, required this.icon});

  final String label;
  final FaIconData icon;

  @override
  Widget build(BuildContext context) {
    return _SettingsButton(
      left: Row(
        children: [
          FaIcon(icon, size: 16, color: SettingsScreen._muted),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: SettingsScreen._text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      right: const _ChevronRight(),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [left, right],
          ),
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: SettingsScreen._divider,
    );
  }
}

class _ChevronRight extends StatelessWidget {
  const _ChevronRight();

  @override
  Widget build(BuildContext context) {
    return const FaIcon(
      FontAwesomeIcons.chevronRight,
      size: 14,
      color: Color(0xFFCCCCCC),
    );
  }
}

class _RedDot extends StatelessWidget {
  const _RedDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      decoration: const BoxDecoration(
        color: SettingsScreen._primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PremiumPlanCard extends StatelessWidget {
  const _PremiumPlanCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFBEB), Color(0xFFFDF2F8)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'プレミアムプラン',
                        style: TextStyle(
                          color: SettingsScreen._text,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '広告なしで快適に！',
                        style: TextStyle(
                          color: SettingsScreen._primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '月額',
                            style: TextStyle(
                              color: SettingsScreen._muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '100',
                            style: TextStyle(
                              color: SettingsScreen._text,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '円（税込）',
                            style: TextStyle(
                              color: SettingsScreen._muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.crown,
                  size: 28,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 54,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: SettingsScreen._primary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '初回7日間 無料',
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
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.rightFromBracket,
                size: 16,
                color: SettingsScreen._primary,
              ),
              SizedBox(width: 8),
              Text(
                'ログアウト',
                style: TextStyle(
                  color: SettingsScreen._primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
