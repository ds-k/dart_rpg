import 'package:dart_rpg/character.dart';

class Monster {
  String name;
  int hp;
  int attack;
  int defence = 0;

  Monster(this.name, this.hp, this.attack, this.defence);

  void attackCharacter(Character character) {
    print("attack character!");
  }

  void showStatus() {
    print("몬스터의 현재 체력은 $hp, 공격력 $attack, 방어력 $defence");
  }
}


/*
- **속성(Property)**
    - 이름 (`String`)
    - 체력 (`int`)
    - 랜덤으로 지정할 공격력 범위 최대값 (`int`)
    → 몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없습니다. 랜덤으로 지정하여 캐릭터의 방어력과 랜덤 값 중 최대값으로 설정해주세요.
    - 방어력(`int`) = 0
    → 몬스터의 방어력은 0이라고 가정합니다.
- **메서드(Method)**
    - 공격 메서드 (`attackCharacter(Character character)`)
        - 캐릭터에게 공격을 가하여 피해를 입힙니다.
        - 캐릭터에게 입히는 데미지는 몬스터의 공격력에서 캐릭터의 방어력을 뺀 값이며, 최소 데미지는 0 이상입니다.
    - 상태를 출력하는 메서드 (`showStatus()`)
        - 몬스터의 현재 체력과 공격력을 매 턴마다 출력합니다.
*/