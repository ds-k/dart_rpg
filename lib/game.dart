import 'package:dart_rpg/character.dart';
import 'package:dart_rpg/monster.dart';

class Game {
  Character character;
  List<Monster> monsterList;
  int monsterKillCount;

  Game(this.character, this.monsterList, this.monsterKillCount);

  void startGame() {
    print("Game start!");
  }

  void battle() {
    print("battle!");
  }

  void getRandomMonster() {
    print("랜덤으로 몬스터를 불러온다.");
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