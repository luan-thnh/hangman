import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GameInfo {
  int level;
  int rating;
  bool isPlaying;

  GameInfo(
      {required this.level, required this.rating, required this.isPlaying});

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'rating': rating,
      'isPlaying': isPlaying,
    };
  }

  factory GameInfo.fromMap(Map<String, dynamic> map) {
    return GameInfo(
      level: map['level'],
      rating: map['rating'],
      isPlaying: map['isPlaying'],
    );
  }
}

class SharedPref {
  static Future setGameInfos(List<GameInfo> gameInfos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> gameInfoList =
        gameInfos.map((gameInfo) => jsonEncode(gameInfo.toMap())).toList();
    await prefs.setStringList('gameInfos', gameInfoList);
  }

  static Future<List<GameInfo>> getGameInfos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? gameInfoList = prefs.getStringList('gameInfos');
    if (gameInfoList == null)  return [GameInfo(level: 1, rating: 0, isPlaying: true) ];
    return gameInfoList.map((gameInfo) => GameInfo.fromMap(jsonDecode(gameInfo))).toList();
  }
}
