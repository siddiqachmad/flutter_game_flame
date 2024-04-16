import 'package:flame/components.dart';
import 'package:flutter_flame_tutorial/pages/ember_quest_game.dart';

class EmberPlayer extends SpriteAnimationComponent with HasGameReference<EmberQuestGame>{
  EmberPlayer({
    required super.position
  }): super(size: Vector2(32, 32), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("ember.png"),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}