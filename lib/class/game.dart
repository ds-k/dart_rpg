import 'dart:math';

import 'package:dart_rpg/class/character.dart';
import 'package:dart_rpg/class/monster.dart';
import 'dart:io';

import 'package:dart_rpg/helper/load_character_stats.dart';
import 'package:dart_rpg/helper/load_monster_list.dart';
import 'package:dart_rpg/helper/load_result_data.dart';
import 'package:dart_rpg/util/check_regex.dart';
import 'package:dart_rpg/util/check_save.dart';

class Game {
  Character? character;
  List<Monster>? monsterList;
  int monsterKillCount = 0;
  int gameCount = 0;

  Future<void> startGame() async {
    try {
      String? name = await getCharacterName();
      if (name == null) {
        throw Exception("올바른 이름이 입력되지 않았습니다.");
      }
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
      return;
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
      print("행동을 선택하세요 (1: 공격, 2: 방어, 3: 공격력 2배 스킬)");

      try {
        switch (stdin.readLineSync() as String) {
          case "1":
            character?.attackMonster(randomMonster);
            // 몬스터가 죽은 경우
            if (randomMonster.hp <= 0) {
              print("${randomMonster.name}을 물리쳤습니다!");
              monsterList?.remove(randomMonster);
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
            character?.defend(randomMonster);
            break;
          case "3":
            character?.useSkill();

            if (character?.skillFlag == 1) {
              character?.attackMonster(randomMonster);
            }
            // 몬스터가 죽은 경우
            if (randomMonster.hp <= 0) {
              print("${randomMonster.name}을 물리쳤습니다!");
              monsterList?.remove(randomMonster);
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
            continue;
          default:
            throw Exception("잘못된 선택입니다. 게임을 다시 시작해 주세요.");
        }
      } catch (e) {
        print(e.toString().substring(11));
        return;
      }
      // 몬스터의 턴
      gameCount += 1;
      if (gameCount == 3) {
        randomMonster.defense += 2;
        print(
            "${randomMonster.name}의 방어력이 증가했습니다! 현재 방어력 ${randomMonster.defense}");
        gameCount = 0;
      }
      print("\n${randomMonster.name}의 턴");
      randomMonster.attackCharacter(character!);

      // 캐릭터가 죽지 않았을 경우 진행을 위해 캐릭터와 몬스터의 상태 노출
      if (character!.hp > 0) {
        character?.showStatus();
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

  Future<String?> getCharacterName() async {
    print("플레이할 이름을 선택해주세요.");
    print("1. 새로운 이름으로 플레이하기");
    print("2. 기존에 진행한 이름으로 플레이하기");
    try {
      switch (stdin.readLineSync() as String) {
        case "1":
          print("캐릭터의 이름을 입력하세요 : ");

          String name = stdin.readLineSync() as String;

          while (!checkRegex(name)) {
            print("한글과 영문만 입력 가능합니다. 다시 입력해주세요!");
            name = stdin.readLineSync() as String;
          }
          return name;

        case "2":
          print("기존에 진행했던 이름 목록입니다.");
          List<List<dynamic>>? resultData = await loadResultData();
          // null일때 처리 추가할 필요 있지만, 현재는 데이터가 있어 향후 리팩토링 계획
          for (int i = 0; i < resultData!.length; i++) {
            print(
                "${i + 1}. ${resultData[i][0]} / hp : ${resultData[i][1]} / 승리 여부 : ${resultData[i][2]}");
          }
          int idx = int.parse(stdin.readLineSync() as String);
          if (idx > resultData.length) {
            throw Exception("잘못된 선택입니다. 게임을 다시 시작해 주세요.");
          }
          return resultData.toList()[idx - 1][0];

        default:
          throw Exception("잘못된 선택입니다. 게임을 다시 시작해 주세요.");
      }
    } catch (e) {
      print(e.toString().substring(11));
      return null;
    }
  }
}
