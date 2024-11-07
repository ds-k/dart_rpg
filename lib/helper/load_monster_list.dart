import 'dart:io';
import 'package:dart_rpg/class/monster.dart';

Future<List<Monster>?> loadMonsterListAsync() async {
  try {
    final file = File('assets/db/monsters.csv');
    final lines = await file.readAsLines();
    List<Monster> monsters = [];
    for (String line in lines) {
      List<dynamic> lineList = line.split(",");
      if (lineList.length != 3) throw FormatException('Invalid monsters data');
      monsters.add(
          Monster(lineList[0], int.parse(lineList[1]), int.parse(lineList[2])));
    }

    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    return null;
  }
}
