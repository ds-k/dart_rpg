# dart_rpg
![dartRpg](https://github.com/user-attachments/assets/f6c49e9f-d5bd-4144-90fa-1e2f13f77f11)

---
## 구현 기능
### 필수
1. 파일로부터 데이터 읽어오기
2. 캐릭터 이름 입력받기
3. 게임 종료 후 결과를 파일에 저장
### 도전
1. 캐릭터 체력 증가 기능
2. 아이템 사용 기능
3. 몬스터 방어력 증가 기능
4. 나만의 기능(기존 데이터에 있는 이름 선택 기능 추가)

---
## 디렉토리 구현
<img width="272" alt="스크린샷 2024-11-08 오전 2 31 03" src="https://github.com/user-attachments/assets/bf0ff412-30b8-48b6-83bf-fa5c086fd2d9">

* assets - 캐릭터, 몬스터, 결과 값을 가지고 있는 csv를 db 폴더로 분리해서 관리
* lib - class, helper, util로 구분해서 관리
  * class - character, monster, game 클래스로 나누어 속성과 메서드를 관리
  * helper - assets/db에 있는 파일들을 읽고 쓰는 함수들만 따로 모아 관리
  * util - 정규식으로 이름을 체크하는 함수와, 반복되는 y/n으로 응답을 받는 함수를 관리
* bin/dart_rpg - main함수가 있는 곳

---
## 주요 기능 소개
### csv 데이터를 읽고 쓰는 기능
* 데이터를 읽는 기능은 dart.io의 File 클래스의 readAsString과 readAsLine 메서드를 이용하여 구현했습니다.
* csv를 받아 ,를 기준으로 데이터를 트리밍해서 전달합니다.
* 데이터를 쓰는 기능은 dart.io의 File 클래스의 writeAsString 메서드를 이용하여 구현했습니다.
* 데이터를 쓸 때, 덮어쓰지 않고 추가될수 있도록 writeAsString 메서드에 mode: FileMode.append 옵션을 이용했습니다.

### 전투(battle())의 구성
* 몬스터의 공격력은 최대로 지정된 공격력과 캐릭터의 방어력 사이의 랜덤한 값을 갖도록 했습니다.
* 랜덤한 값은 dart.math의 Random 클래스를 이용하여 범위를 지정하는 형태로 구성했습니다.
* while문을 활용해 캐릭터의 hp가 0이 될때 종료될 수 있도록 구현했습니다.
* monsterList에서 랜덤하게 뽑은 randomMonster의 hp가 0이 되면, 해당 몬스터를 monsterList에서 제거하고 다시 randomMonster를 뽑도록 구현했습니다.
* monsterList에 값이 없을때(monsterList.isEmpty) 게임은 종료되며 result.csv에 저장될 수 있도록 했습니다.

### 도전 기능의 구성
* 30%의 확률로 캐릭터의 체력이 증가하는 기능은 dart.math의 Random().nextDouble()을 통해 0과 1사이의 소수값을 받고, 그 값이 0.3보다 작거나 같을때 체력이 증가할 수 있도록 했습니다.
* 아이템 사용 기능은 skillFlag라는 변수를 character 클래스에 추가하여 구현하였습니다.
  * skillFlag의 최초값은 0입니다.
  * useSkill 메서드를 사용하면, skillFlag는 1이 되고 몬스터를 공격합니다.
  * skillFlag가 1이라면 공격력을 두배로 만들어 몬스터를 공격한 후에 skillFlag에 1을 더해줍니다.
  * skillFlag가 2가 되면 공격시 skillFlag가 2일때 공격력을 2로 나눠 기존 공격력 값으로 대체합니다. 그리고 skillFlag에 1을 더해줍니다.
  * 이후 스킬 사용시 0이 아니기 때문에 skill 사용은 더이상 못하게 되고, 1도 아니기 때문에 공격력에 변화도 없습니다.
* 몬스터 방어력 증가 기능은 game 클래스에 gameCount 변수를 선언하여, 턴이 3번 지나면 방어력을 올려주고 gameCount를 초기화 하는 방식으로 구성했습니다.
  * 몬스터의 방어력 증가는 캐릭터의 공격력보다 1이 작을때까지만 커질 수 있도록 구성했습니다. 몬스터의 방어력이 캐릭터의 공격력을 초과하면 더 이상 게임을 진행할 수 없기 때문입니다.
* 나만의 기능은 최초 시작시 새로운 이름을 입력하는 것과 기존 result.csv에 저장된 이름을 가져와 선택하는 방식으로 나눈 것입니다.
  * dart.io File 클래스의 readAsLine 메서드를 이용해서 값을 받습니다.
  * resultList를 반복문을 돌면서 읽어온 result.csv의 값을 보여주고, 입력을 받아 해당 index의 값의 이름으로 진행할 수 있도록 했습니다.

