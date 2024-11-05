import 'dart:io';
import 'package:dart_rpg/class/monster.dart';

Future<List<Monster>?> loadMonsterListAsync() async {
  try {
    final file = File('assets/db/monsters.csv');
    final lines = await file.readAsLines();
    List<Monster> monsters = [];
    for (var line in lines) {
      monsters.add(Monster(line[0], int.parse(line[1]), int.parse(line[2])));
    }
    if (monsters.length != 3) throw FormatException('Invalid monsters data');
    return monsters;
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    return null;
  }
}
