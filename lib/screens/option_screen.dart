import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';
import 'package:hangman/constants/words.dart';
import 'package:hangman/screens/home_screen.dart';
import 'package:hangman/utils/shared_preferences.dart';
import 'package:hangman/widgets/button_primary.dart';
import 'package:hangman/widgets/dialog.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  WordKey? wordKey = WordKey.technology;

  @override
  void initState() {
    super.initState();
    _loadLevelFromSharedPreferences();
  }

  Future<void> _loadLevelFromSharedPreferences() async {
    wordKey = await SharedPref.getWordKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Settings',
            style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.w600, fontFamily: 'PermanentMarker', letterSpacing: 2),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 32),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Select a Genre',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontFamily: 'SpecialElite'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ButtonPrimary(
                          text: 'Choose type',
                          padding: 12,
                          sizeText: 14,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: typeList
                                            .map((type) => TextButton(
                                                onPressed: () {},
                                                child: Theme(
                                                  data: ThemeData(unselectedWidgetColor: AppColors.bgColor),
                                                  child: ListTile(
                                                    title: Text(
                                                      type,
                                                      style: const TextStyle(
                                                          color: AppColors.bgColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'SpecialElite'),
                                                    ),
                                                    leading: Radio<WordKey>(
                                                      value: WordKey.values[typeList.indexOf(type)],
                                                      groupValue: wordKey,
                                                      activeColor: AppColors.bgColor,
                                                      onChanged: (WordKey? value) async {
                                                        setState(() {
                                                          wordKey = value;
                                                        });

                                                        await SharedPref.setWordKey(wordKey!);
                                                      },
                                                    ),
                                                    onTap: () async {
                                                      setState(() {
                                                        wordKey = WordKey.values[typeList.indexOf(type)];
                                                        Navigator.pop(context);
                                                      });
                                                      await SharedPref.setWordKey(wordKey!);
                                                    },
                                                  ),
                                                )))
                                            .toList(),
                                      )),
                                );
                              },
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Do you want to restart?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontFamily: 'SpecialElite'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ButtonPrimary(
                          text: 'Restart',
                          padding: 12,
                          sizeText: 14,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogWidget(
                                    heading: 'Restart',
                                    subHeading: 'Do You Want To Restart The Game?',
                                    handleSetLevel: () async {
                                      await SharedPref.setGameInfos(wordKey!, [GameInfo(level: 1, rating: 0, isPlaying: true)]);

                                      if (!context.mounted) return;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                      );
                                    },
                                    handleLickBtnNo: () {
                                      Navigator.pop(context);
                                    });
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const Text(
                'Developed by LuanThnh',
                style: TextStyle(color: Colors.white60, fontFamily: 'SpecialElite'),
              )
            ],
          ),
        ));
  }
}
