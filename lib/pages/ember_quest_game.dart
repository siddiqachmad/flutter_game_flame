import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flame_tutorial/actors/water_enemy.dart';
import 'package:flutter_flame_tutorial/managers/segment_manager.dart';
import 'package:flutter_flame_tutorial/objects/ground_block.dart';
import 'package:flutter_flame_tutorial/objects/platform_block.dart';
import 'package:flutter_flame_tutorial/objects/star.dart';
import 'package:flutter_flame_tutorial/overlays/hud.dart';
import 'package:flutter_flame_tutorial/pages/ember_player.dart';

class EmberQuestGame extends FlameGame with HasCollisionDetection,HasKeyboardHandlerComponents,DragCallbacks{
  EmberQuestGame();
  late EmberPlayer _ember;
  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  int starsCollected = 0;
  int health = 3;
  late JoystickComponent joystick;
  @override
  Future<void> onLoad() async {
    // Load your game assets here
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart.png',
      'heart_half.png',
      'star.png',
      'water_enemy.png',
      'Joystick.png',
      'JumpButton.png',
      'Knob.png'
    ]);
    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame(true);
    addJoystick();
    // _ember = EmberPlayer(
    //   position: Vector2(128, canvasSize.y - 70),
    // );
    // world.add(_ember);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
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

  void initializeGame(bool loadHud) {
    addJoystick();
    addJumpButton();
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );
    world.add(_ember);

    if (loadHud) {
      add(Hud());
    }

  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('GameOver');
    }
    updateJoystick();
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 100,
      knob: SpriteComponent(
        priority: 100,
        sprite: Sprite(images.fromCache('Knob.png')),
      ),
      background: SpriteComponent(
        priority: 100,
        sprite: Sprite(images.fromCache('Joystick.png')),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
      knobRadius: 32,
    );
    add(joystick);
  }

  void addJumpButton(){
    final jumpButton = SpriteComponent(
      sprite: Sprite(images.fromCache('JumpButton.png')),
      position: Vector2(size.x - 64, size.y - 64),
      size: Vector2.all(64),
      anchor: Anchor.center,
    );
    add(jumpButton);
  }


  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        _ember.horizontalDirection = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        _ember.horizontalDirection = 1;
        break;
      default:
        _ember.horizontalDirection = 0;
        break;
    }

  }
}