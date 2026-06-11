import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../widgets/app_widgets.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
                  child: AppHeader(
                    title: '投稿の詳細',
                    rightIcon: Icons.more_horiz,
                    onLeft: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      SoftCard(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const AvatarCircle(index: 0, size: 48),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'たけたけ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          BadgeText('関西エリア'),
                                          SizedBox(width: 8),
                                          Text(
                                            '今日 09:41',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: AppColors.muted,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              '梅田あたり\n鳴りやすい！',
                              style: TextStyle(
                                fontSize: 21,
                                height: 1.35,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'コメント（4件）',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final c in comments) CommentRow(comment: c),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, bottom + 14),
                  child: const SendInputBar(
                    placeholder: 'コメントを入力...',
                    counter: '',
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

class BadgeText extends StatelessWidget {
  const BadgeText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.blueBadge,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: AppColors.blue,
        ),
      ),
    );
  }
}

class CommentRow extends StatelessWidget {
  const CommentRow({super.key, required this.comment});
  final CommentInfo comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            AvatarCircle(size: 38, index: comment.avatarIndex),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    comment.text,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Text(
              comment.time,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
