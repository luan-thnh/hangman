import 'package:hangman/constants/words.dart';

String generatorWord(index, type) {
  return wordsList[type]![index];
}
