import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_tutorial/pages/ember_quest_game.dart';

class EmberPlayer extends SpriteAnimationComponent with KeyboardHandler, HasGameReference<EmberQuestGame>{
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    return true;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    velocity.x = horizontalDirection * moveSpeed;
    position += velocity * dt;
    super.update(dt);

  }
}