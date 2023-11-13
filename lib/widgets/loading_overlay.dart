import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';
import 'package:hangman/constants/images_url.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final Future<void>? future;

  const LoadingOverlay({Key? key, required this.child, required this.future})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: AppColors.bgColor,
            child: const Center(
              child: Image(
                image: AssetImage(ImagesUrl.logo),
                width: 300,
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}

// class LoadingOverlay extends StatelessWidget {
//   final Widget child;
//   final bool isLoading;
//
//   const LoadingOverlay({Key? key, required this.child, required this.isLoading})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         child,
//         if (isLoading)
//           Container(
//             color: AppColors.bgColor,
//             child: const Center(
//               child: Image(
//                 image: AssetImage(ImagesUrl.logo),
//                 width: 300,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
