import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Settings',
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'PermanentMarker',
                letterSpacing: 2),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you want to restart?',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontFamily: 'SpecialElite'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonPrimary(
                        text: 'Restart',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogWidget(
                                  heading: 'Restart',
                                  subHeading:
                                      'Do You Want To Restart The Game?',
                                  handleSetLevel: () async {
                                    await SharedPref.setGameInfos([
                                      GameInfo(
                                          level: 1, rating: 0, isPlaying: true)
                                    ]);

                                    if (!context.mounted) return;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
                                  },
                                  handleLickBtnNo: () {
                                    Navigator.pop(context);
                                  });
                            },
                          );
                        }),
                  ],
                ),
              ),
              const Text(
                'Developed by LuanThnh',
                style: TextStyle(
                    color: Colors.white60, fontFamily: 'SpecialElite'),
              )
            ],
          ),
        ));
  }
}
