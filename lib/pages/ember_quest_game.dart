import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_tutorial/actors/water_enemy.dart';
import 'package:flutter_flame_tutorial/managers/segment_manager.dart';
import 'package:flutter_flame_tutorial/objects/ground_block.dart';
import 'package:flutter_flame_tutorial/objects/platform_block.dart';
import 'package:flutter_flame_tutorial/objects/star.dart';
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
    initializeGame();
    // _ember = EmberPlayer(
    //   position: Vector2(128, canvasSize.y - 70),
    // );
    // world.add(_ember);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          break;
        case PlatformBlock:
          break;
        case Star:
          break;
        case WaterEnemy:
          break;
      }
    }
  }

  void initializeGame() {
    // Assume that size.x < 3200
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ember);
  }
}