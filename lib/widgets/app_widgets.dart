import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/app_assets.dart';
import '../core/app_theme.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color,
    this.radius = 24,
  });
  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: softShadow(.10),
      ),
      child: child,
    );
  }
}

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: AppColors.primary.withValues(alpha: .28),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
            if (icon != null) ...[
              const SizedBox(width: 22),
              Icon(icon, size: 22),
            ],
          ],
        ),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          side: const BorderSide(color: Color(0xFF1C5D9E), width: 1.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          backgroundColor: Colors.white.withValues(alpha: .72),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.badge,
  });
  final IconData icon;
  final VoidCallback? onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .32),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.text, size: 24),
          ),
        ),
        if (badge != null)
          Positioned(
            right: 2,
            top: 1,
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

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.leftIcon = Icons.arrow_back_ios_new,
    this.rightIcon,
    this.onLeft,
    this.onRight,
  });
  final String title;
  final IconData leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundIconButton(
          icon: leftIcon,
          onTap: onLeft ?? () => Navigator.maybePop(context),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        if (rightIcon != null)
          RoundIconButton(icon: rightIcon!, onTap: onRight)
        else
          const SizedBox(width: 40),
      ],
    );
  }
}

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key, this.size = 46, this.index = 0});
  final double size;
  final int index;

  @override
  Widget build(BuildContext context) {
    final alignments = [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
    ];
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: softShadow(.08),
        border: Border.all(color: Colors.white, width: 3),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        AppAssets.avatarsSheet,
        fit: BoxFit.cover,
        alignment: alignments[index % alignments.length],
      ),
    );
  }
}

class StatusDot extends StatelessWidget {
  const StatusDot({super.key, this.online = true});
  final bool online;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: online ? const Color(0xFF2ECC71) : AppColors.muted,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD36D),
        borderRadius: BorderRadius.circular(99),
      ),
      child: const Text(
        'Premium',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.asset,
    required this.child,
    this.blur = 0,
  });
  final String asset;
  final Widget child;
  final double blur;

  @override
  Widget build(BuildContext context) {
    Widget bg = Image.asset(
      asset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
    if (blur > 0) {
      bg = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: bg,
      );
    }
    return Stack(
      children: [
        Positioned.fill(child: bg),
        Positioned.fill(
          child: Container(color: Colors.white.withValues(alpha: .08)),
        ),
        child,
      ],
    );
  }
}

class SendInputBar extends StatelessWidget {
  const SendInputBar({
    super.key,
    required this.placeholder,
    this.counter = '0/10',
    this.onInfo,
  });
  final String placeholder;
  final String counter;
  final VoidCallback? onInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .94),
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow(.12),
      ),
      child: Row(
        children: [
          if (onInfo != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onInfo,
              icon: const Icon(Icons.info_outline, color: AppColors.primary),
            ),
          Expanded(
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Color(0xFFB8B8C4),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Text(
            counter,
            style: const TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: softShadow(.12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (FontAwesomeIcons.locationDot, '地図'),
      (FontAwesomeIcons.users, 'フレンド'),
      (FontAwesomeIcons.user, 'マイページ'),
    ];
    return Container(
      height: 72,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 10),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .98),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: .18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: .88),
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: AnimatedScale(
                  scale: index == i ? 1.04 : 1,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        items[i].$1,
                        size: i == 1 ? 22 : 24,
                        color:
                            index == i
                                ? AppColors.primary
                                : const Color(0xFF171717),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          items[i].$2,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            color:
                                index == i
                                    ? AppColors.primary
                                    : const Color(0xFF111111),
                          ),
                        ),
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
