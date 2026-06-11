import 'package:flutter/material.dart';

class RegionInfo {
  const RegionInfo(
    this.name,
    this.people,
    this.posts,
    this.color,
    this.alignment,
  );
  final String name;
  final int people;
  final int posts;
  final Color color;
  final Alignment alignment;
}

class FriendInfo {
  const FriendInfo(
    this.name,
    this.status,
    this.message,
    this.avatarIndex, {
    this.online = true,
  });
  final String name;
  final String status;
  final String message;
  final int avatarIndex;
  final bool online;
}

class CommentInfo {
  const CommentInfo(this.name, this.text, this.time, this.avatarIndex);
  final String name;
  final String text;
  final String time;
  final int avatarIndex;
}

const regions = [
  RegionInfo('北海道', 128, 56, Color(0xFF2F80ED), Alignment(.16, -.62)),
  RegionInfo('北陸', 96, 41, Color(0xFF1DA7C9), Alignment(-.34, -.30)),
  RegionInfo('東北', 148, 72, Color(0xFF11A7C7), Alignment(.70, -.14)),
  RegionInfo('中部', 109, 96, Color(0xFFFF4A59), Alignment(-.50, .02)),
  RegionInfo('関西', 211, 105, Color(0xFFFF3045), Alignment(.58, .18)),
  RegionInfo('中国', 75, 31, Color(0xFFF5A400), Alignment(.22, .50)),
  RegionInfo('九州', 122, 62, Color(0xFFFF3045), Alignment(-.66, .72)),
];

const friends = [
  FriendInfo('たけたけ', 'オンライン', '梅田あたり、鳴りやすい！', 0),
  FriendInfo('ユウキ', 'オンライン', '今、北新地です！', 1),
  FriendInfo('まつつー', 'オンライン', '雨やばいですね☔', 2),
  FriendInfo('りょう', 'オフライン（2時間前）', 'あつかれさまです！', 3, online: false),
  FriendInfo('なおこ', 'オンライン', 'よろしくお願いします😊', 4),
];

const comments = [
  CommentInfo('ユウキ', '自分も今梅田です！', '09:42', 1),
  CommentInfo('なお', '北新地もよかったですよ〜', '09:43', 2),
  CommentInfo('まつつー', 'ありがとうございます！', '09:45', 3),
  CommentInfo('りょう', '雨やばいですね☔', '09:46', 4),
];
