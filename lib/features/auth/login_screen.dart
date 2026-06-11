import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../home_shell.dart';

const _loveableRed = Color(0xFFE63946);
const _loveableText = Color(0xFF1F1F1F);
const _loveableBodyText = Color(0xDD2D2D2D);
const _loveableMuted = Color(0xFF999999);
const _loveableBorder = Color(0xFFE0DCD5);
const _loveableChip = Color(0xFFF7F2EA);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  )..forward();
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  bool _showLoginForm = false;
  int? _signupStep;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE9DD),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.splashLoginBg, fit: BoxFit.cover),
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
          const _PetalLayer(),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BrandPill(),
                            SizedBox(height: 12),
                            Text(
                              '配達員のための\n地域別チャットアプリ',
                              style: TextStyle(
                                fontSize: 28,
                                height: 1.16,
                                fontWeight: FontWeight.w900,
                                color: _loveableText,
                                letterSpacing: 0,
                                shadows: [
                                  Shadow(
                                    color: Color(0x99FFFFFF),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '地域を選んで、つながろう！',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _loveableBodyText,
                                shadows: [
                                  Shadow(
                                    color: Color(0x99FFFFFF),
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fade,
                      child: SlideTransition(
                        position: Tween(
                          begin: const Offset(0, .08),
                          end: Offset.zero,
                        ).animate(_fade),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 240),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeOutCubic,
                            transitionBuilder:
                                (child, animation) => FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween(
                                      begin: const Offset(0, .06),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                ),
                            child:
                                _signupStep != null
                                    ? _SignupCard(
                                      key: ValueKey('signup-$_signupStep'),
                                      step: _signupStep!,
                                      onBack:
                                          () => setState(() {
                                            if (_signupStep! > 0) {
                                              _signupStep = _signupStep! - 1;
                                            } else {
                                              _signupStep = null;
                                            }
                                          }),
                                      onNext:
                                          () => setState(() {
                                            if (_signupStep! < 2) {
                                              _signupStep = _signupStep! + 1;
                                            } else {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => const HomeShell(),
                                                ),
                                              );
                                            }
                                          }),
                                      onLogin:
                                          () => setState(() {
                                            _signupStep = null;
                                            _showLoginForm = true;
                                          }),
                                    )
                                    : _showLoginForm
                                    ? _LoginFormCard(
                                      key: const ValueKey('login-form'),
                                      onBack:
                                          () => setState(
                                            () => _showLoginForm = false,
                                          ),
                                      onLogin:
                                          () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => const HomeShell(),
                                            ),
                                          ),
                                      onSignup:
                                          () => setState(() {
                                            _showLoginForm = false;
                                            _signupStep = 0;
                                          }),
                                    )
                                    : _SplashActions(
                                      key: const ValueKey('splash-actions'),
                                      onLogin:
                                          () => setState(
                                            () => _showLoginForm = true,
                                          ),
                                      onSignup:
                                          () => setState(() => _signupStep = 0),
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
        ],
      ),
    );
  }
}

class _SignupCard extends StatelessWidget {
  const _SignupCard({
    super.key,
    required this.step,
    required this.onBack,
    required this.onNext,
    required this.onLogin,
  });

  final int step;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SignupHeader(step: step, onBack: onBack),
          const SizedBox(height: 18),
          if (step == 0)
            _SignupAccountStep(onNext: onNext, onLogin: onLogin)
          else if (step == 1)
            _SignupProfileStep(onNext: onNext, onLogin: onLogin)
          else
            _SignupIntroStep(onNext: onNext, onLogin: onLogin),
        ],
      ),
    );
  }
}

class _SignupHeader extends StatelessWidget {
  const _SignupHeader({required this.step, required this.onBack});

  final int step;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          behavior: HitTestBehavior.opaque,
          child: const Row(
            children: [
              Icon(Icons.chevron_left, color: _loveableMuted, size: 18),
              SizedBox(width: 3),
              Text(
                '戻る',
                style: TextStyle(
                  color: _loveableMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: List.generate(3, (index) {
            final active = index == step;
            final passed = index < step;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 24 : 12,
              height: 6,
              decoration: BoxDecoration(
                color:
                    active
                        ? _loveableRed
                        : passed
                        ? _loveableRed.withValues(alpha: .50)
                        : _loveableBorder,
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
        const Spacer(),
        SizedBox(
          width: 34,
          child: Text(
            '${step + 1}/3',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _loveableMuted,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignupAccountStep extends StatelessWidget {
  const _SignupAccountStep({required this.onNext, required this.onLogin});

  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SignupTitle('アカウント情報'),
        const SizedBox(height: 24),
        const _AuthInput(icon: Icons.person_outline, hint: 'ニックネームを入力'),
        const SizedBox(height: 12),
        const _AuthInput(
          icon: Icons.mail_outline,
          hint: 'email@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        const _AuthInput(
          icon: Icons.lock_outline,
          hint: '••••••••',
          obscureText: true,
        ),
        const SizedBox(height: 24),
        _FormSubmitButton(label: '次へ', onTap: onNext),
        const SizedBox(height: 24),
        const _DividerLabel(),
        const SizedBox(height: 16),
        _GoogleButton(onTap: onNext),
        const SizedBox(height: 18),
        _ExistingAccountLink(onTap: onLogin),
      ],
    );
  }
}

class _SignupProfileStep extends StatelessWidget {
  const _SignupProfileStep({required this.onNext, required this.onLogin});

  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SignupTitle('プロフィール設定'),
        const SizedBox(height: 24),
        const _SignupSectionLabel('活動エリアを選択'),
        const SizedBox(height: 10),
        const Wrap(
          spacing: 9,
          runSpacing: 10,
          children: [
            _ChoiceChipLabel('北海道'),
            _ChoiceChipLabel('東北'),
            _ChoiceChipLabel('関東', selected: true),
            _ChoiceChipLabel('中部'),
            _ChoiceChipLabel('近畿'),
            _ChoiceChipLabel('中国'),
            _ChoiceChipLabel('四国'),
            _ChoiceChipLabel('九州'),
          ],
        ),
        const SizedBox(height: 24),
        const _SignupSectionLabel('主な配達手段'),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _VehicleSignupChip(icon: Icons.directions_walk, label: '徒歩'),
            _VehicleSignupChip(icon: Icons.pedal_bike, label: '自転車'),
            _VehicleSignupChip(
              icon: Icons.delivery_dining,
              label: 'バイク',
              selected: true,
            ),
            _VehicleSignupChip(icon: Icons.directions_car, label: '車'),
            _VehicleSignupChip(icon: Icons.more_horiz, label: 'その他'),
          ],
        ),
        const SizedBox(height: 24),
        const _SignupSectionLabel('配達歴'),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ChoiceChipLabel('半年未満'),
            _ChoiceChipLabel('1〜2年', selected: true),
            _ChoiceChipLabel('3〜5年'),
            _ChoiceChipLabel('5年以上'),
          ],
        ),
        const SizedBox(height: 24),
        _FormSubmitButton(label: '次へ', onTap: onNext),
        const SizedBox(height: 18),
        _ExistingAccountLink(onTap: onLogin),
      ],
    );
  }
}

class _SignupIntroStep extends StatelessWidget {
  const _SignupIntroStep({required this.onNext, required this.onLogin});

  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SignupTitle('あと少し！'),
        const SizedBox(height: 24),
        const _SignupSectionLabel('自己紹介'),
        const SizedBox(height: 10),
        Container(
          height: 112,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _loveableBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
              hintText: 'よろしくお願いします！',
              hintStyle: TextStyle(
                color: Color(0xFF8D9098),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6EF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shariq',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '📍 関東 · 🛵 バイク · 1〜2年',
                style: TextStyle(
                  color: Color(0xFF6B6B6B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _FormSubmitButton(label: '✓  完了して始める', onTap: onNext),
        const SizedBox(height: 18),
        _ExistingAccountLink(onTap: onLogin),
      ],
    );
  }
}

class _SignupTitle extends StatelessWidget {
  const _SignupTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF2D2D2D),
        fontSize: 14,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _SignupSectionLabel extends StatelessWidget {
  const _SignupSectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6B6B6B),
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ChoiceChipLabel extends StatelessWidget {
  const _ChoiceChipLabel(this.label, {this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? _loveableRed : _loveableChip,
        borderRadius: BorderRadius.circular(14),
        boxShadow:
            selected
                ? [
                  BoxShadow(
                    color: _loveableRed.withValues(alpha: .25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xFF6B6B6B),
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _VehicleSignupChip extends StatelessWidget {
  const _VehicleSignupChip({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 72,
      decoration: BoxDecoration(
        color: selected ? _loveableRed : _loveableChip,
        borderRadius: BorderRadius.circular(18),
        boxShadow:
            selected
                ? [
                  BoxShadow(
                    color: _loveableRed.withValues(alpha: .25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: selected ? Colors.white : const Color(0xFF6B6B6B)),
          const SizedBox(height: 7),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF6B6B6B),
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExistingAccountLink extends StatelessWidget {
  const _ExistingAccountLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(
            'すでにアカウントをお持ちの方 → ログイン',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _loveableRed,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashActions extends StatelessWidget {
  const _SplashActions({
    super.key,
    required this.onLogin,
    required this.onSignup,
  });

  final VoidCallback onLogin;
  final VoidCallback onSignup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SplashActionButton(label: 'ログイン', filled: true, onTap: onLogin),
        const SizedBox(height: 12),
        _SplashActionButton(label: '新規登録', onTap: onSignup),
        const SizedBox(height: 20),
        const Center(child: _LanguagePill()),
      ],
    );
  }
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard({
    super.key,
    required this.onBack,
    required this.onLogin,
    required this.onSignup,
  });

  final VoidCallback onBack;
  final VoidCallback onLogin;
  final VoidCallback onSignup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          const _AuthInput(
            icon: Icons.mail_outline,
            hint: 'email@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          const _AuthInput(
            icon: Icons.lock_outline,
            hint: '••••••••',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          _FormSubmitButton(onTap: onLogin),
          const SizedBox(height: 16),
          const _DividerLabel(),
          const SizedBox(height: 16),
          _GoogleButton(onTap: onLogin),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onSignup,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'アカウントをお持ちでない方 → 新規登録',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _loveableRed,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '← 戻る',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthInput extends StatelessWidget {
  const _AuthInput({
    required this.icon,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
  });

  final IconData icon;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0DCD5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF999999)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: const TextStyle(fontSize: 14, color: _loveableText),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF8D9098),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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

class _FormSubmitButton extends StatelessWidget {
  const _FormSubmitButton({required this.onTap, this.label = 'ログイン'});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _loveableRed,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .16),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE0DCD5), height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'または',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE0DCD5), height: 1)),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0DCD5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GoogleMark(),
                SizedBox(width: 10),
                Text(
                  'Googleでログイン',
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
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

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        color: Color(0xFF4285F4),
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _PetalLayer extends StatelessWidget {
  const _PetalLayer();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          const petals = [
            _Petal(top: .08, left: .06, size: 22, degrees: -20, opacity: .70),
            _Petal(top: .14, left: .82, size: 18, degrees: 30, opacity: .60),
            _Petal(top: .38, left: .78, size: 26, degrees: 45, opacity: .50),
            _Petal(top: .52, left: .10, size: 20, degrees: -40, opacity: .50),
            _Petal(top: .70, left: .85, size: 24, degrees: 10, opacity: .55),
          ];
          return Stack(
            children:
                petals
                    .map(
                      (petal) => Positioned(
                        top: height * petal.top,
                        left: width * petal.left,
                        child: petal,
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }
}

class _Petal extends StatelessWidget {
  const _Petal({
    required this.top,
    required this.left,
    required this.size,
    required this.degrees,
    required this.opacity,
  });

  final double top;
  final double left;
  final double size;
  final double degrees;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: degrees * math.pi / 180,
        child: CustomPaint(
          size: Size.square(size),
          painter: const _PetalPainter(),
        ),
      ),
    );
  }
}

class _PetalPainter extends CustomPainter {
  const _PetalPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 32, size.height / 32);
    final petal =
        Path()
          ..moveTo(16, 2)
          ..cubicTo(12, 9, 12, 14, 16, 18)
          ..cubicTo(20, 14, 20, 9, 16, 2)
          ..close();
    canvas.drawPath(petal, Paint()..color = const Color(0xFFFFB7C5));
    canvas.drawCircle(const Offset(16, 16), 1.4, Paint()..color = _loveableRed);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BrandPill extends StatelessWidget {
  const _BrandPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .85),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: _loveableRed, size: 6),
          SizedBox(width: 6),
          Text(
            'ちいきトーク · Chiiki Talk',
            style: TextStyle(
              color: _loveableRed,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashActionButton extends StatelessWidget {
  const _SplashActionButton({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1,
      duration: const Duration(milliseconds: 120),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: filled ? _loveableRed : Colors.white,
            border: filled ? null : Border.all(color: _loveableRed, width: 2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:
                    filled
                        ? _loveableRed.withValues(alpha: .30)
                        : Colors.black.withValues(alpha: .06),
                blurRadius: filled ? 16 : 4,
                offset: filled ? const Offset(0, 8) : const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: filled ? Colors.white : _loveableRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (filled)
                    const Positioned(
                      right: 24,
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 22,
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

class _LanguagePill extends StatelessWidget {
  const _LanguagePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .85),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, size: 16, color: Color(0xFF2D2D2D)),
          SizedBox(width: 8),
          Text(
            '日本語',
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
