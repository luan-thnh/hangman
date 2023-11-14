import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';

class HiddenLetter extends StatelessWidget {
  final String char;
  final bool visible;

  const HiddenLetter({Key? key, required this.char, required this.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.textColor,
            width: 2.0,
          ),
        ),
      ),
      child: Visibility(
          visible: !visible,
          child: Text(
            char,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SpecialElite',
                color: AppColors.textColor,
                fontSize: 18),
          )),
    );
  }
}
