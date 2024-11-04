import 'package:dart_rpg/monster.dart';

class Character {
  String name;
  int hp;
  int attack;
  int defence;

  Character(this.name, this.hp, this.attack, this.defence);

  void attackMonster(Monster monster) {
    print("attack monster!");
  }

  void defend() {
    print("defend!");
  }

  void showStatus() {
    print("캐릭터의 현재 체력은 $hp, 공격력 $attack, 방어력 $defence");
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