import 'dart:math';

import 'package:dart_rpg/class/character.dart';
import 'package:dart_rpg/class/monster.dart';
import 'dart:io';

import 'package:dart_rpg/helper/load_character_stats.dart';
import 'package:dart_rpg/helper/load_monster_list.dart';
import 'package:dart_rpg/util/check_regex.dart';

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

      print("\n게임을 시작합니다!");
      print(
          "${character?.name} - 체력: ${character?.hp}, 공격력: ${character?.attack}, 방어력: ${character?.defense}");
    } catch (e) {
      print(e.toString().substring(11));
    }
  }

  void battle() async {
    Monster randomMonster = await getRandomMonster();
    // 캐릭터의 체력이 0 이하가 되면 게임이 종료
    print("\n새로운 몬스터가 나타났습니다!");
    print(
        "${randomMonster.name} - 체력: ${randomMonster.hp}, 공격력: ${randomMonster.attack}");
    while (character!.hp > 0) {
      // 캐릭터의 행동
      print("\n${character!.name}의 턴");
      print("행동을 선택하세요 (1: 공격, 2: 방어)");

      switch (stdin.readLineSync() as String) {
        case "1":
          character!.attackMonster(randomMonster);
          // 몬스터 체력이 0 이하
          if (randomMonster.hp <= 0) {
            print("${randomMonster.name}을 물리쳤습니다!");
            monsterKillCount += 1;
            print("\n다음 몬스터와 싸우시겠습니까?");
            switch (stdin.readLineSync() as String) {
              case "y":
              case "Y":
                monsterList!.remove(randomMonster);
                print(monsterList);
                battle();
                return;
              case "n":
              case "N":
                print("게임을 종료합니다. 도중에 종료한 게임은 저장되지 않습니다.");
                return;
            }
            break;
          }
        case "2":
          character!.defend(randomMonster);
          break;
      }
      // 몬스터의 행동
      print("\n${randomMonster.name}의 턴");
      randomMonster.attackCharacter(character!);

      if (character!.hp <= 0) {
        return;
      }

      character!.showStatus();
      randomMonster.showStatus();
    }

    // 캐릭터 죽음
    print("\n${character!.name}이 죽었습니다. 다음에 다시 도전해 주세요.");
    return;
  }

  Future<Monster> getRandomMonster() async {
    Random random = Random();
    int randomIdx = random.nextInt(monsterList!.length);

    Monster randomMonster = monsterList![randomIdx];

    int min = character?.defense ?? 1;
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

/*
- **속성(Property)**
    - 캐릭터 (`Character`)
    - 몬스터 리스트 (`List<Monster>`)
    - 물리친 몬스터 개수(`int`)
        - 몬스터 리스트의 개수보다 클 수 없습니다.
- **메서드(Method)**
    - 게임을 시작하는 메서드 (`startGame()`)
        - 캐릭터의 체력이 0 이하가 되면 **게임이 종료**됩니다.
        - 몬스터를 물리칠 때마다 다음 몬스터와 대결할 건지 선택할 수 있습니다.
        예) “다음 몬스터와 대결하시겠습니까? (y/n)”
        - 설정한 물리친 몬스터 개수만큼 몬스터를 물리치면 게임에서 **승리**합니다.
    - 전투를 진행하는 메서드 (`battle()`)
        - 게임 중에 사용자는 매 턴마다 **행동을 선택**할 수 있습니다.
        예) 공격하기(1), 방어하기(2)
        - 매 턴마다 몬스터는 사용자에게 공격만 가합니다.
        - 캐릭터는 몬스터 리스트에 있는 몬스터들 중 랜덤으로 뽑혀서 **대결을** 합니다.
        - 처치한 몬스터는 몬스터 리스트에서 삭제되어야 합니다.
        - 캐릭터의 체력은 대결 **간에 누적**됩니다.
    - 랜덤으로 몬스터를 불러오는 메서드(`getRandomMonster()`)
        - `Random()` 을 사용하여 몬스터 리스트에서 랜덤으로 몬스터를 반환하여 대결합니다.
- 힌트
    - 반복문을 사용하여 몬스터를 랜덤으로 뽑으며 순회하면서 대결을 진행합니다.
*/
