import 'dart:io';

import 'package:dart_rpg/class/character.dart';

Future<Character?> loadCharacterStatsAsync(String name) async {
  try {
    final file = File('assets/db/characters.csv');
    final contents = await file.readAsString();
    final stats = contents.split(',');

    if (stats.length != 3) throw FormatException('Invalid character data');
    int hp = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    return Character(name, hp, attack, defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    return null;
  }
}
