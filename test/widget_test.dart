import 'package:chat_app/main.dart';
import 'package:chat_app/features/friends/friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows Japanese login screen', (tester) async {
    await tester.pumpWidget(const ChiikiTalkApp());

    expect(find.text('配達員のための\n地域別チャットアプリ'), findsOneWidget);
    expect(find.text('ログイン'), findsOneWidget);
    expect(find.text('新規登録'), findsOneWidget);
  });

  testWidgets('splash login button shows form and back restores actions', (
    tester,
  ) async {
    await tester.pumpWidget(const ChiikiTalkApp());

    await tester.tap(find.text('ログイン').first);
    await tester.pumpAndSettle();

    expect(find.text('email@example.com'), findsOneWidget);
    expect(find.text('Googleでログイン'), findsOneWidget);

    await tester.tap(find.text('← 戻る'));
    await tester.pumpAndSettle();

    expect(find.text('email@example.com'), findsNothing);
    expect(find.text('新規登録'), findsOneWidget);
  });

  testWidgets('signup wizard advances through three overlay steps', (
    tester,
  ) async {
    await tester.pumpWidget(const ChiikiTalkApp());

    await tester.tap(find.text('新規登録'));
    await tester.pumpAndSettle();

    expect(find.text('アカウント情報'), findsOneWidget);
    expect(find.text('1/3'), findsOneWidget);

    await tester.tap(find.text('次へ'));
    await tester.pumpAndSettle();

    expect(find.text('プロフィール設定'), findsOneWidget);
    expect(find.text('2/3'), findsOneWidget);

    await tester.tap(find.text('次へ'));
    await tester.pumpAndSettle();

    expect(find.text('あと少し！'), findsOneWidget);
    expect(find.text('3/3'), findsOneWidget);

    await tester.tap(find.text('すでにアカウントをお持ちの方 → ログイン'));
    await tester.pumpAndSettle();

    expect(find.text('Googleでログイン'), findsOneWidget);
  });

  testWidgets('friend tabs switch and conversation opens chat', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: FriendsScreen(showBottomNav: false)),
    );

    await tester.tap(find.text('承認待ち'));
    await tester.pumpAndSettle();

    expect(find.text('承認待ちです'), findsWidgets);

    await tester.tap(find.text('フレンド'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('たけたけ'));
    await tester.pumpAndSettle();

    expect(find.text('関西エリア'), findsOneWidget);
  });
}
