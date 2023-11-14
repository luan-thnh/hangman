import 'package:flutter/material.dart';
import 'package:hangman/constants/images_url.dart';
import 'package:hangman/screens/game_screen.dart';
import 'package:hangman/screens/level_screen.dart';
import 'package:hangman/screens/option_screen.dart';
import 'package:hangman/widgets/button_primary.dart';
import 'package:hangman/widgets/loading_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void>? future;

  @override
  void initState() {
    super.initState();
    future = null;
  }

  void handleNavigator(screen) {
    if (screen != null) {
      setState(() {
        future = Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen!),
        );
      });
    } else {
      throw Exception('Screen is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(isLoading);
    return LoadingOverlay(
      future: future,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(ImagesUrl.logo)),
                    Text(
                      'HANGMAN',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'PermanentMarker',
                        letterSpacing: 5.0,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text('The Game',
                        style: TextStyle(
                          fontFamily: 'SpecialElite',
                          letterSpacing: 2.0,
                        ))
                  ],
                ),
                Column(
                  children: [
                    ButtonPrimary(
                      text: 'Play'.toUpperCase(),
                      screen: const GameScreen(),
                      onPressed: () {
                        handleNavigator(const GameScreen());
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonPrimary(
                      text: 'Level'.toUpperCase(),
                      screen: const LevelScreen(),
                      onPressed: () {
                        handleNavigator(const LevelScreen());
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonPrimary(
                      text: 'Option'.toUpperCase(),
                      screen: const OptionScreen(),
                      onPressed: () {
                        handleNavigator(const OptionScreen());
                      },
                    )
                  ],
                ),
                const Text(
                  'Developed by LuanThnh',
                  style: TextStyle(
                      color: Colors.white60, fontFamily: 'SpecialElite'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
