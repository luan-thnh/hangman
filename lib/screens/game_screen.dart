import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';
import 'package:hangman/constants/images_url.dart';
import 'package:hangman/screens/home_screen.dart';
import 'package:hangman/utils/generator_word.dart';
import 'package:hangman/utils/shared_preferences.dart';
import 'package:hangman/widgets/dialog.dart';
import 'package:hangman/widgets/figure.dart';
import 'package:hangman/widgets/hidden_letter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> selectedChar = [];

  var tries = 0;
  var level = 1;
  var rating = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  _initializeData() async {
    List<GameInfo> gameInfos = await SharedPref.getGameInfos();
    GameInfo playingGame = gameInfos.firstWhere((game) => game.isPlaying);

    bool hasSameLevel =
        gameInfos.any((info) => info.level == playingGame.level);

    if (!hasSameLevel) {
      gameInfos = [...gameInfos, playingGame];
      await SharedPref.setGameInfos(gameInfos);
    }

    setState(() {
      level =
          playingGame.toMap()['level'] == 0 ? 1 : playingGame.toMap()['level'];
      rating = playingGame.toMap()['rating'];
    });
  }

  void handleNextLevel() async {
    setState(() {
      if (tries == 6) {
        rating = 0;
      } else if (tries <= 5 && tries >= 4) {
        rating = 1;
      } else if (tries <= 3 && tries >= 2) {
        rating = 2;
      } else if (tries <= 1 && tries >= 0) {
        rating = 3;
      }
    });

    GameInfo gameInfo =
        GameInfo(level: level, rating: rating, isPlaying: false);
    List<GameInfo> gameInfos = await SharedPref.getGameInfos();

    int index = gameInfos.indexWhere((info) => info.level == gameInfo.level);

    if (index != -1) {
      gameInfos[index] = gameInfo;
    } else {
      gameInfos.add(gameInfo);
    }

    gameInfos.forEach((info) => info.isPlaying = false);

    int nextLevelIndex =
        gameInfos.indexWhere((info) => info.level == level + 1);
    if (nextLevelIndex != -1) {
      gameInfos[nextLevelIndex].isPlaying = true;
    } else {
      gameInfos.add(GameInfo(level: level + 1, rating: 0, isPlaying: true));
    }

    await SharedPref.setGameInfos(gameInfos);

    setState(() {
      tries = 0;
      level++;
      selectedChar = [];
    });
  }

  void handleAgainLevel() {
    setState(() {
      tries = 0;
      level = level;
      selectedChar = [];

      if (level == wordsList.length) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen()),
                (Route route) => false,
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Technology',
          style: TextStyle(
              color: AppColors.textColor,
              fontFamily: 'PermanentMarker',
              letterSpacing: 2),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Figure(path: ImagesUrl.hang, visible: tries >= 0),
                Figure(path: ImagesUrl.head, visible: tries >= 1),
                Figure(path: ImagesUrl.body, visible: tries >= 2),
                Figure(path: ImagesUrl.leftArm, visible: tries >= 3),
                Figure(path: ImagesUrl.rightArm, visible: tries >= 4),
                Figure(path: ImagesUrl.leftLeg, visible: tries >= 5),
                Figure(path: ImagesUrl.rightLeg, visible: tries >= 6),
              ],
            )),
            Text(
              'Level ${level}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SpecialElite',
              ),
            ),
          ],
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 8,
                        spacing: 8,
                        children: generatorWord(level - 1)
                            .split('')
                            .map((char) => HiddenLetter(
                                char: char.toUpperCase(),
                                visible:
                                    !selectedChar.contains(char.toUpperCase())))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 3,
              //   child: GridView.count(
              //     crossAxisCount: 7,
              //     mainAxisSpacing: 12,
              //     crossAxisSpacing: 12,
              //     children: characters
              //         .split('')
              //         .map((char) => TextButton(
              //             style: TextButton.styleFrom(
              //               foregroundColor: AppColors.textColor,
              //               shape: RoundedRectangleBorder(
              //                 side: BorderSide(
              //                   color: AppColors.textColor.withOpacity(0.8),
              //                   width: 1.0,
              //                 ),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               backgroundColor: Colors.transparent,
              //             ),
              //             onPressed: selectedChar.contains(char.toUpperCase())
              //                 ? null
              //                 : () {
              //                     setState(() {
              //                       selectedChar.add(char.toUpperCase());
              //                       if (!generatorWord(level - 1)
              //                           .split('')
              //                           .contains(char.toLowerCase())) tries++;
              //                     });
              //
              //                     tries >= 6
              //                         ? showDialog(
              //                             context: context,
              //                             builder: (BuildContext context) {
              //                               return DialogWidget(
              //                                   heading: 'GameOver',
              //                                   subHeading:
              //                                       'Do You Want To Play Again?',
              //                                   handleSetLevel:
              //                                       handleAgainLevel,
              //                                   handleLickBtnNo: () {
              //                                     Navigator.push(
              //                                       context,
              //                                       MaterialPageRoute(
              //                                           builder: (context) =>
              //                                               const HomeScreen()),
              //                                     );
              //                                   });
              //                             },
              //                           )
              //                         : null;
              //
              //                     if (generatorWord(level - 1).split('').every(
              //                         (char) => selectedChar
              //                             .contains(char.toUpperCase()))) {
              //                       showDialog(
              //                         context: context,
              //                         builder: (BuildContext context) {
              //                           return DialogWidget(
              //                               heading: 'Level Cleared',
              //                               subHeading:
              //                                   'Do You Want To Play Next Level!',
              //                               handleSetLevel: handleNextLevel,
              //                               handleLickBtnNo: handleNextLevel);
              //                         },
              //                       );
              //                     }
              //                   },
              //             child: Text(
              //               char,
              //               style: const TextStyle(
              //                   fontSize: 18, fontWeight: FontWeight.bold),
              //             )))
              //         .toList(),
              //   ),
              // ),
              Expanded(
                flex: 4,
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(characters.length, (index) {
                    return SizedBox(
                      width: 44,
                      height: 44,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.textColor,
                            foregroundColor: AppColors.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: selectedChar
                                  .contains(characters[index].toUpperCase())
                              ? null
                              : () {
                                  setState(() {
                                    selectedChar
                                        .add(characters[index].toUpperCase());
                                    if (!generatorWord(level - 1)
                                        .split('')
                                        .contains(
                                            characters[index].toLowerCase())) {
                                      tries++;
                                    }
                                  });

                                  tries >= 6
                                      ? showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return DialogWidget(
                                                heading: 'GameOver',
                                                subHeading:
                                                    'Do You Want To Play Again?',
                                                handleSetLevel:
                                                    handleAgainLevel,
                                                handleLickBtnNo: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()),
                                                  );
                                                });
                                          },
                                        )
                                      : null;

                                  if (generatorWord(level - 1).split('').every(
                                      (char) => selectedChar
                                          .contains(char.toUpperCase()))) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return DialogWidget(
                                            heading: 'Level Cleared',
                                            subHeading:
                                                'Do You Want To Play Next Level!',
                                            handleSetLevel: handleNextLevel,
                                            handleLickBtnNo: () {
                                              handleAgainLevel();
                                              Navigator.pop(context);
                                            });
                                      },
                                    );
                                  }
                                },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              characters[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SpecialElite',
                              ),
                            ),
                          )),
                    );
                  }),
                ),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
