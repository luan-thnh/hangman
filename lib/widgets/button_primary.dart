import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';

class ButtonPrimary extends StatefulWidget {
  final Widget? screen;
  final String? text;
  final VoidCallback? onPressed;

  ButtonPrimary({super.key, this.text, this.screen, this.onPressed});

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
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
            backgroundColor: MaterialStateProperty.all(AppColors.textColor),
            // side: MaterialStateProperty.all(
            //     const BorderSide(color: Colors.white, width: 2)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999))),
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.text!,
            style: const TextStyle(
                color: AppColors.bgColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )),
    );
  }
}
