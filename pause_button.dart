import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart'; // <-- REQUIRED for Canvas, Paint, Color, Rect

import '../tower_defense_game.dart';

class PauseButton extends PositionComponent with TapCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(40, 40);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white;

    // Draw pause icon (two vertical bars)
    canvas.drawRect(
      Rect.fromLTWH(8, 5, 8, size.y - 10),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.x - 16, 5, 8, size.y - 10),
      paint,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    final game = findGame() as TowerDefenseGame;
    game.openPauseMenu();
  }
}