import 'package:flame/components.dart';
import 'package:flame/game.dart';

class EmberQuestGame extends FlameGame{
  EmberQuestGame();

  Future<void> onLoad() async {
    // Load your game assets here
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart.png',
      'heart_half.png',
      'star.png',
      'water_enemy.png'
    ]);
    camera.viewfinder.anchor = Anchor.topLeft;
  }

}