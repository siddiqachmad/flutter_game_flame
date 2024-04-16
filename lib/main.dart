import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_tutorial/pages/ember_quest_game.dart';

void main() {
  runApp(
    const GameWidget<EmberQuestGame>.controlled(gameFactory: EmberQuestGame.new)
  );
}

