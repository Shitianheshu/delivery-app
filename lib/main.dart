import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'features/auth/login_screen.dart';

void main() {
  runApp(const ChiikiTalkApp());
}

class ChiikiTalkApp extends StatelessWidget {
  const ChiikiTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ちいきトーク',
      theme: buildAppTheme(),
      home: const LoginScreen(),
    );
  }
}
