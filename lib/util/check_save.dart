import 'dart:io';

import 'package:dart_rpg/class/character.dart';
import 'package:dart_rpg/helper/write_result_data.dart';

void checkSave(Character character, bool isWin) {
  print("결과를 저장하시겠습니까? (y/n)");
  try {
    switch (stdin.readLineSync() as String) {
      case "y":
      case "Y":
        writeResultData(character, isWin);
        print("결과를 저장하고, 게임을 종료합니다.");
        return;
      case "n":
      case "N":
        print("결과를 저장하지 않고, 게임을 종료합니다.");
        return;
      default:
        throw Exception("잘못된 선택으로 결과는 저장되지 않습니다.");
    }
  } catch (e) {
    print(e.toString().substring(11));
  }
}
