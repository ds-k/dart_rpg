import 'package:dart_rpg/class/monster.dart';

class Character {
  String name;
  int hp;
  int attack;
  int defense;

  Character(this.name, this.hp, this.attack, this.defense);

  void attackMonster(Monster monster) {
    monster.hp = monster.hp - attack;
    print("\n$name이(가) ${monster.name}에게 $attack의 데미지를 입혔습니다.");
  }

  void defend(Monster monster) {
    // 몬스터의 공격력에서 캐릭터의 방어력을 뺀만큼 회복
    int healVal = monster.attack - defense;
    hp += healVal;
    print("$name이(가) 방어 태세를 취하여 $healVal 만큼 체력을 얻었습니다.");
  }

  void showStatus() {
    print("\n$name의 현재 체력은 $hp, 공격력은 $attack, 방어력은 $defense 입니다");
  }
}


/*
- **속성(Property)**
    - 이름 (`String`)
    - 체력 (`int`)
    - 공격력 (`int`)
    - 방어력 (`int`)
- **메서드(Method)**
    - 공격 메서드 (`attackMonster(Monster monster)`)
        - 몬스터에게 공격을 가하여 피해를 입힙니다.
    - 방어 메서드 (`defend()`)
        - 방어 시 특정 행동을 수행합니다.
        예) 대결 상대인 몬스터가 입힌 데미지만큼 캐릭터의 체력을 상승시킵니다.
    - 상태를 출력하는 메서드 (`showStatus()`)
        - 캐릭터의 현재 체력, 공격력, 방어력을 매 턴마다 출력합니다.
*/