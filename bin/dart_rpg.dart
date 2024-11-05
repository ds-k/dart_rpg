import 'package:dart_rpg/class/game.dart';

void main(List<String> arguments) async {
  Game game = Game();

  await game.startGame();
  await game.getRandomMonster();
}
