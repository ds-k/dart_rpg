import 'package:dart_rpg/class/monster.dart';

class Character {
  String name;
  int hp;
  int attack;
  int defense;
  int skillFlag =
      0; // 0일 때는 스킬을 쓰지 않음, 1일 때는 사용했고 공격력 두배가 적용되는 한 턴, 2는 사용은 했지만 공격력 두배는 적용 안됨

  Character(this.name, this.hp, this.attack, this.defense);

  void attackMonster(Monster monster) {
    if (skillFlag == 1) {
      attack = attack * 2; // 공격력 두배
      skillFlag += 1; // skill
    } else if (skillFlag == 2) {
      attack = attack ~/ 2; // 사용한 이후라 공격력 복구 (나누고 내림해서 정수만 하는 연산자 사용)
      skillFlag += 1; // 더이상 공격력 연산이 없게끔 복구 이후에 더해주기
    }
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

  void useSkill() {
    if (skillFlag == 0) {
      print("스킬을 사용했습니다! 한 턴 동안 공격력 두배!");
      skillFlag += 1;
    } else {
      print("이미 스킬을 사용했습니다.");
    }
  }
}
