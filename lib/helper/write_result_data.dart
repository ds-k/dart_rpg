import 'dart:io';

import 'package:dart_rpg/class/character.dart';

void writeResultData(Character character, bool isWin) {
  String name = character.name;
  String hp = character.hp.toString();
  String result = isWin ? "win" : "lose";

  final file = File("assets/db/result.csv");
  final String data = "$name,$hp,$result\n";

  file.writeAsString(data, mode: FileMode.append);
}
