// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';

// class Tower extends PositionComponent  {
//   double hp = 100;

//   Tower({required Vector2 position}) {
//     this.position = position;
//     size = Vector2(40, 40);
//     anchor = Anchor.center;
//   }

//   void takeDamage(double dmg) {
//     hp -= dmg;
//     if (hp < 0) {
//       hp = 0;
//     }
//   }

//   @override
//   void render(Canvas canvas) {
//     final paint = Paint()..color = Colors.blue;
//     canvas.drawRect(size.toRect(), paint);

//     final hpPercent = (hp / 100).clamp(0.0, 1.0);
//     final barWidth = size.x;
//     const barHeight = 5.0;
//     final bgPaint = Paint()..color = Colors.black;
//     final fgPaint = Paint()..color = Colors.green;

//     final bgRect = Rect.fromLTWH(0, -barHeight - 4, barWidth, barHeight);
//     final fgRect =
//         Rect.fromLTWH(0, -barHeight - 4, barWidth * hpPercent, barHeight);

//     canvas.drawRect(bgRect, bgPaint);
//     canvas.drawRect(fgRect, fgPaint);
//   }
// }



import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../tower_defense_game.dart';
import 'enemy.dart';
import 'bullet.dart';

class Tower extends PositionComponent with HasGameRef<TowerDefenseGame> {
  double hp = 100;

  // Shooting
  double fireCooldown = 0.5; // seconds between shots
  double _fireTimer = 0.0;

  Tower({required Vector2 position}) {
    this.position = position;
    size = Vector2(40, 40);
    anchor = Anchor.center;
  }

  void takeDamage(double dmg) {
    hp -= dmg;
    if (hp < 0) {
      hp = 0;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Auto-fire logic
    _fireTimer += dt;
    if (_fireTimer >= fireCooldown) {
      _fireTimer = 0.0;
      _shootAtNearestEnemy();
    }
  }

  void _shootAtNearestEnemy() {
    final enemies = gameRef.children.whereType<Enemy>().toList();
    if (enemies.isEmpty) return;

    // Find nearest enemy
    enemies.sort(
      (a, b) =>
          a.position.distanceTo(position).compareTo(b.position.distanceTo(position)),
    );
    final target = enemies.first;

    final dir = (target.position - position)..normalize();

    final bullet = Bullet(
      position: position.clone(),
      direction: dir,
      damage: 20,
    );

    gameRef.add(bullet);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(size.toRect(), paint);

    final hpPercent = (hp / 100).clamp(0.0, 1.0);
    final barWidth = size.x;
    const barHeight = 5.0;
    final bgPaint = Paint()..color = Colors.black;
    final fgPaint = Paint()..color = Colors.green;

    final bgRect = Rect.fromLTWH(0, -barHeight - 4, barWidth, barHeight);
    final fgRect =
        Rect.fromLTWH(0, -barHeight - 4, barWidth * hpPercent, barHeight);

    canvas.drawRect(bgRect, bgPaint);
    canvas.drawRect(fgRect, fgPaint);
  }
}