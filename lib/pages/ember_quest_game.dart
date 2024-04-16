import 'dart:ui';

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
  double objectSpeed = 0.0;
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
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          world.add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case WaterEnemy:
          world.add(
            WaterEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
      }
    }
  }

  void initializeGame() {
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

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromARGB(255, 173, 223, 247);
  }
}