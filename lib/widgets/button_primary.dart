import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';

class ButtonPrimary extends StatefulWidget {
  final Widget? screen;
  final String? text;
  final VoidCallback? onPressed;
  final double? padding;
  final double? sizeText;

  const ButtonPrimary(
      {super.key,
      this.text,
      this.screen,
      this.onPressed,
      this.padding = 16.0,
      this.sizeText = 16});

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(widget.padding!)),
            backgroundColor: MaterialStateProperty.all(AppColors.textColor),
            // side: MaterialStateProperty.all(
            //     const BorderSide(color: Colors.white, width: 2)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999))),
          ),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.text!,
              style: TextStyle(
                color: AppColors.bgColor,
                fontSize: widget.sizeText,
                fontWeight: FontWeight.w600,
                fontFamily: 'SpecialElite',
              ),
            ),
          )),
    );
  }
}
