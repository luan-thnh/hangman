import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';
import 'package:hangman/screens/game_screen.dart';
import 'package:hangman/utils/generator_word.dart';
import 'package:hangman/utils/shared_preferences.dart';
import 'package:hangman/widgets/loading_overlay.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int level = 1;
  int rating = 0;
  List<GameInfo> gameInfos = [];
  Future<void>? future;

  @override
  void initState() {
    super.initState();
    _loadLevelFromSharedPreferences();
  }

  Future<void> _loadLevelFromSharedPreferences() async {
    gameInfos = await SharedPref.getGameInfos();
    GameInfo playingGame = gameInfos.firstWhere((game) => game.isPlaying);

    setState(() {
      level = playingGame.level == 0 ? 1 : playingGame.level;
      rating = playingGame.rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        future: future,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Level Game',
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    children: wordsList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        int rating = 0;
                        bool isPlaying = false;

                        if (index < gameInfos.length) {
                          rating = gameInfos[index].toMap()['rating'];
                          isPlaying = gameInfos[index].toMap()['isPlaying'];
                        }

                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                index < level ? AppColors.bgColor : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: index < level
                              ? () async {
                                  List<GameInfo> updatedGameInfos =
                                      gameInfos.map((gameInfo) {
                                    return GameInfo(
                                      level: gameInfo.level,
                                      rating: gameInfo.rating,
                                      isPlaying: gameInfo.level == entry.key + 1
                                          ? true
                                          : false,
                                    );
                                  }).toList();

                                  await SharedPref.setGameInfos(
                                      updatedGameInfos);

                                  if (!context.mounted) return;

                                  setState(() {
                                    future = Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GameScreen()),
                                    );
                                  });
                                }
                              : null,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              index < level
                                  ? Positioned(
                                      bottom: -10,
                                      child: Row(
                                        children: List.generate(
                                          3,
                                          (starIndex) {
                                            if (starIndex < rating) {
                                              return const Icon(
                                                Icons.star_rate_rounded,
                                                size: 10,
                                                color: Colors.amber,
                                              );
                                            } else {
                                              return const Icon(
                                                Icons.star_border_rounded,
                                                size: 10,
                                                color: Colors.amber,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  : isPlaying
                                      ? const Positioned(
                                          bottom: -6,
                                          right: -12,
                                          child: Icon(
                                            Icons.lock_open_rounded,
                                            size: 12,
                                          ),
                                        )
                                      : const Positioned(
                                          bottom: -6,
                                          right: -12,
                                          child: Icon(
                                            Icons.lock_outline_rounded,
                                            size: 12,
                                          ),
                                        )
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const Text(
                  'Developed by LuanThnh',
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
        ));
  }
}
