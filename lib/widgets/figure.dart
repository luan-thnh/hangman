import 'package:flutter/material.dart';

class Figure extends StatelessWidget {
  final String path;
  final bool visible;

  const Figure({Key? key, required this.path, required this.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 180,
          child: Visibility(visible: visible, child: Image.asset(path))),
    );
  }
}
