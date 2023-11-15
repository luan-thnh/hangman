import 'dart:convert';

import 'package:hangman/constants/words.dart';
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
  static Future<void> setWordKey(WordKey value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wordKey', value.toString().split('.').last);
  }

  static Future<WordKey?> getWordKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? keyString = prefs.getString('wordKey');

    if (keyString == null) {
      return WordKey.technology;
    }

    return WordKey.values
        .firstWhere((e) => e.toString().split('.').last == keyString);
  }

  static Future setGameInfos(WordKey gameType, List<GameInfo> gameInfos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> gameInfoList =
        gameInfos.map((gameInfo) => jsonEncode(gameInfo.toMap())).toList();

    String type = gameType.toString().split('.').last;
    await prefs.setStringList('game_info_$type', gameInfoList);
  }

  static Future<List<GameInfo>> getGameInfos(WordKey gameType) async {
    final prefs = await SharedPreferences.getInstance();

    String type = gameType.toString().split('.').last;
    List<String>? gameInfoList = prefs.getStringList('game_info_$type');

    if (gameInfoList == null) {
      return [GameInfo(level: 1, rating: 0, isPlaying: true)];
    }

    return gameInfoList
        .map((gameInfo) => GameInfo.fromMap(jsonDecode(gameInfo)))
        .toList();
  }
}
