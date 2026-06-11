import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/app_assets.dart';
import '../../widgets/app_widgets.dart';
import '../settings/settings_screen.dart';

const _profileRed = Color(0xFFE63946);
const _profileText = Color(0xFF2D2D2D);
const _profileMuted = Color(0xFF6B6B6B);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.showBottomNav = true});
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BackgroundImage(
        asset: AppAssets.sakuraBg,
        blur: 1.2,
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  _ProfileHeader(
                    onSettings:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
                      child: const _ProfilePanel(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          showBottomNav ? AppBottomNav(index: 2, onTap: (_) {}) : null,
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 52),
          const Expanded(
            child: Center(
              child: Text(
                'マイプロフィール',
                style: TextStyle(
                  color: _profileText,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.userPlus,
                color: _profileText,
                size: 19,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onSettings,
                behavior: HitTestBehavior.opaque,
                child: const FaIcon(
                  FontAwesomeIcons.gear,
                  color: _profileText,
                  size: 19,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProfileIdentity(),
          const SizedBox(height: 28),
          const _SectionTitle('乗り物', suffix: '（複数選択可）'),
          const SizedBox(height: 10),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                VehicleChip(icon: FontAwesomeIcons.shoePrints, label: '徒歩'),
                SizedBox(width: 8),
                VehicleChip(icon: FontAwesomeIcons.bicycle, label: '自転車'),
                SizedBox(width: 8),
                VehicleChip(
                  icon: FontAwesomeIcons.motorcycle,
                  label: 'バイク',
                  selected: true,
                ),
                SizedBox(width: 8),
                VehicleChip(icon: FontAwesomeIcons.carSide, label: '車'),
                SizedBox(width: 8),
                VehicleChip(icon: FontAwesomeIcons.ellipsis, label: 'その他'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('活動エリア', suffix: '（複数選択可）'),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AreaChip('北海道'),
              AreaChip('東北'),
              AreaChip('関東'),
              AreaChip('中部'),
              AreaChip('近畿', selected: true),
              AreaChip('中国'),
              AreaChip('四国'),
              AreaChip('九州'),
            ],
          ),
          const SizedBox(height: 24),
          const _IntroSection(),
        ],
      ),
    );
  }
}

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: _profileRed,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .18),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .14),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.camera,
                      color: _profileRed,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Shariq',
            style: TextStyle(
              color: _profileText,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '配達歴: 2年目',
            style: TextStyle(
              color: _profileMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {required this.suffix});
  final String text;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _profileText,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
        children: [
          TextSpan(
            text: ' $suffix',
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleChip extends StatelessWidget {
  const VehicleChip({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
  });
  final FaIconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? _profileRed : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: selected ? .16 : .07),
            blurRadius: selected ? 12 : 7,
            offset: Offset(0, selected ? 6 : 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 20,
            color: selected ? Colors.white : _profileMuted,
          ),
          const SizedBox(height: 7),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : _profileMuted,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class AreaChip extends StatelessWidget {
  const AreaChip(this.label, {super.key, this.selected = false});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? _profileRed : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: selected ? .15 : .07),
            blurRadius: selected ? 10 : 6,
            offset: Offset(0, selected ? 5 : 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : _profileMuted,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (selected) ...[
            const SizedBox(width: 5),
            const FaIcon(FontAwesomeIcons.pen, color: Colors.white, size: 10),
          ],
        ],
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              '自己紹介',
              style: TextStyle(
                color: _profileText,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            Spacer(),
            FaIcon(FontAwesomeIcons.pen, color: _profileRed, size: 11),
            SizedBox(width: 4),
            Text(
              '編集',
              style: TextStyle(
                color: _profileRed,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .07),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'よろしくお願いします！',
            style: TextStyle(
              color: _profileText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
