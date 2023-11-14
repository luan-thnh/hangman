import 'package:flutter/material.dart';
import 'package:hangman/constants/colors.dart';

class DialogWidget extends StatelessWidget {
  final String? heading, subHeading;
  Function handleSetLevel, handleLickBtnNo;

  DialogWidget(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.handleSetLevel,
      required this.handleLickBtnNo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            Text(
              heading!,
              style: const TextStyle(
                color: AppColors.bgColor,
                fontSize: 24,
                fontFamily: 'PermanentMarker',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              subHeading!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.bgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SpecialElite'),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black, width: 2)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999))),
                  ),
                  onPressed: () {
                    handleLickBtnNo();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SpecialElite',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black, width: 2)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999))),
                  ),
                  onPressed: () {
                    handleSetLevel();
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SpecialElite',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
