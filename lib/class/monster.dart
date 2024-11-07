import 'dart:math';

import 'package:dart_rpg/class/character.dart';

class Monster {
  String name;
  int hp;
  int attack;
  int defense = 0;

  Monster(this.name, this.hp, this.attack);

  void attackCharacter(Character character) {
    Random random = Random();
    // 공격력 계산
    // 공격력에서 캐릭터의 방어력을 뺀 값이 0이면 0
    // 0이 아니면 해당 값부터 캐릭터의 방어력 사이의 랜덤값
    int calcAttack = attack - character.defense;
    int randomAttack =
        calcAttack == 0 ? 0 : random.nextInt(calcAttack) + character.defense;
    int monsterAttack = randomAttack - character.defense;

    // 캐릭터의 hp가 음수가 되는 것을 방지하기 위해 0 이하로 떨어지면 0으로 변경
    character.hp = character.hp - monsterAttack;
    if (character.hp < 0) character.hp = 0;

    print("$name이(가) ${character.name}에게 $monsterAttack의 데미지를 입혔습니다.");
  }

  void showStatus() {
    print("$name의 현재 체력은 $hp, 공격력은 $attack 입니다.");
  }
}
