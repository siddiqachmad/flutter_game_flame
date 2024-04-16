import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_tutorial/pages/ember_player.dart';

class EmberQuestGame extends FlameGame{
  EmberQuestGame();
  late EmberPlayer _ember;
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

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ember);
  }

}