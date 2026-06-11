import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/app_assets.dart';
import '../../core/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../widgets/app_widgets.dart';
import '../chat/chat_room_screen.dart';

class RegionSelectionScreen extends StatelessWidget {
  const RegionSelectionScreen({super.key, this.showBottomNav = true});
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BackgroundImage(
        // Japan map illustration used as the tappable region canvas.
        asset: AppAssets.japanMapBg,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 94),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const _HomeHeaderIcon(
                          icon: FontAwesomeIcons.magnifyingGlass,
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              '地域を選択',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const _HomeHeaderIcon(
                          icon: FontAwesomeIcons.bell,
                          badge: '3',
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          for (final region in regions)
                            Align(
                              alignment: region.alignment,
                              child: RegionCard(region: region),
                            ),
                          Align(
                            alignment: const Alignment(.62, .84),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '地域をタップして\nチャットルームへ！',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    height: 1.45,
                                  ),
                                ),
                                Transform.rotate(
                                  angle: -.6,
                                  child: const FaIcon(
                                    FontAwesomeIcons.arrowRotateRight,
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          showBottomNav ? AppBottomNav(index: 0, onTap: (_) {}) : null,
    );
  }
}

class RegionCard extends StatefulWidget {
  const RegionCard({super.key, required this.region});
  final RegionInfo region;

  @override
  State<RegionCard> createState() => _RegionCardState();
}

class _RegionCardState extends State<RegionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ChatRoomScreen()));
      },
      child: AnimatedScale(
        scale: _pressed ? .94 : 1,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 116,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .74),
            border: Border.all(
              color: widget.region.color.withValues(alpha: .55),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: widget.region.color.withValues(alpha: .22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.users,
                    color: widget.region.color,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.region.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.region.people}人',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: widget.region.color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FaIcon(
                    FontAwesomeIcons.comment,
                    color: widget.region.color,
                    size: 12,
                  ),
                  Text(
                    '${widget.region.posts}件',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: widget.region.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeaderIcon extends StatelessWidget {
  const _HomeHeaderIcon({required this.icon, this.badge});

  final FaIconData icon;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .32),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(child: FaIcon(icon, color: AppColors.text, size: 20)),
        ),
        if (badge != null)
          Positioned(
            right: 1,
            top: 0,
            child: Container(
              height: 16,
              constraints: const BoxConstraints(minWidth: 16),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
