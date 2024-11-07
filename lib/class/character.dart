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
