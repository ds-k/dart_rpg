import 'dart:math';

import 'package:dart_rpg/class/character.dart';
import 'package:dart_rpg/class/monster.dart';
import 'dart:io';

import 'package:dart_rpg/helper/load_character_stats.dart';
import 'package:dart_rpg/helper/load_monster_list.dart';
import 'package:dart_rpg/util/check_regex.dart';
import 'package:dart_rpg/util/check_save.dart';

class Game {
  Character? character;
  List<Monster>? monsterList;
  int monsterKillCount = 0;

  Future<void> startGame() async {
    try {
      String name = getCharacterName();
      character = await loadCharacterStatsAsync(name);
      monsterList = await loadMonsterListAsync();

      if (character == null) {
        throw Exception("캐릭터를 찾을 수 없습니다.");
      }

      double random = Random().nextDouble();

      print("\n게임을 시작합니다!");
      if (random <= 0.3) {
        character?.hp = character!.hp + 10;
        print("보너스 체력을 얻었습니다! 현재 체력: ${character?.hp}");
      }
      print(
          "${character?.name} - 체력: ${character?.hp}, 공격력: ${character?.attack}, 방어력: ${character?.defense}");
    } catch (e) {
      print(e.toString().substring(11));
    }
  }

  void battle() async {
    Monster randomMonster = await getRandomMonster();

    print("\n새로운 몬스터가 나타났습니다!");
    print(
        "${randomMonster.name} - 체력: ${randomMonster.hp}, 공격력: ${randomMonster.attack}");

    // 캐릭터의 체력이 0 이하가 되면 게임이 종료
    while (character!.hp > 0) {
      // 캐릭터의 턴
      print("\n${character!.name}의 턴");
      print("행동을 선택하세요 (1: 공격, 2: 방어)");

      try {
        switch (stdin.readLineSync() as String) {
          case "1":
            character!.attackMonster(randomMonster);
            // 몬스터가 죽은 경우
            if (randomMonster.hp <= 0) {
              print("${randomMonster.name}을 물리쳤습니다!");
              monsterList!.remove(randomMonster);
              monsterKillCount += 1;
              if (monsterList!.isEmpty) {
                print("축하합니다! 모든 몬스터를 물리쳤습니다.");
                checkSave(character!, true);
                return;
              }

              print("\n다음 몬스터와 싸우시겠습니까? (y/n)");
              switch (stdin.readLineSync() as String) {
                case "y":
                case "Y":
                  battle();
                  return;
                case "n":
                case "N":
                  print("게임을 종료합니다. 도중에 종료한 게임은 저장되지 않습니다.");
                  return;
                default:
                  throw Exception("잘못된 선택입니다. 게임을 다시 시작해 주세요.");
              }
            }
          case "2":
            character!.defend(randomMonster);
            break;
          default:
            throw Exception("잘못된 선택입니다. 게임을 다시 시작해 주세요.");
        }
      } catch (e) {
        print(e.toString().substring(11));
        return;
      }
      // 몬스터의 턴
      print("\n${randomMonster.name}의 턴");
      randomMonster.attackCharacter(character!);

      // 캐릭터가 죽지 않았을 경우 진행을 위해 캐릭터와 몬스터의 상태 노출
      if (character!.hp > 0) {
        character!.showStatus();
        randomMonster.showStatus();
      }
    }

    // 캐릭터가 죽은 경우
    print("\n${character!.name}이(가) 죽었습니다. 다음에 다시 도전해 주세요.");
    checkSave(character!, false);
  }

  Future<Monster> getRandomMonster() async {
    Random random = Random();
    int randomIdx = random.nextInt(monsterList!.length);

    Monster randomMonster = monsterList![randomIdx];

    int min = character!.defense;
    int max = randomMonster.attack;

    randomMonster.attack = random.nextInt(max - min) + min;

    return randomMonster;
  }

  String getCharacterName() {
    print("캐릭터의 이름을 입력하세요 : ");

    String name = stdin.readLineSync() as String;

    while (!checkRegex(name)) {
      print("한글과 영문만 입력 가능합니다. 다시 입력해주세요!");
      name = stdin.readLineSync() as String;
    }
    return name;
  }
}
