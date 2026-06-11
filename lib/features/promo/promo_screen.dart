import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_theme.dart';
import '../../widgets/app_widgets.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        asset: AppAssets.sakuraBg,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 22, 26, 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RoundIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(AppAssets.appLogo, width: 112),
                    const SizedBox(height: 20),
                    const Text(
                      'ちいきトーク',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'Chiiki Talk',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.muted,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SoftCard(
                      radius: 22,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PromoFeature('シンプルで使いやすい'),
                          PromoFeature('地域でつながる'),
                          PromoFeature('10文字つぶやき'),
                          PromoFeature('コメントで交流'),
                          PromoFeature('安心の通報機能'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppAssets.riderFront,
                      height: 210,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoFeature extends StatelessWidget {
  const PromoFeature(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFE8FAEF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 15, color: Color(0xFF23B26D)),
          ),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
