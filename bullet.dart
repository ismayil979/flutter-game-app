// import 'package:flame/components.dart';
// import 'package:flame/collisions.dart';
// import 'package:flutter/material.dart';

// import 'enemy.dart';

// class Bullet extends PositionComponent
//     with CollisionCallbacks, HasGameRef {
//   final Vector2 direction;
//   final double speed;
//   final double damage;

//   Bullet({
//     required Vector2 position,
//     required this.direction,
//     required this.speed,
//     required this.damage,
//   }) {
//     this.position = position;
//     size = Vector2(10, 10);
//     anchor = Anchor.center;
//   }

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     add(RectangleHitbox());
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     position += direction * speed * dt;

//     if (position.x < -50 ||
//         position.x > gameRef.size.x + 50 ||
//         position.y < -50 ||
//         position.y > gameRef.size.y + 50) {
//       removeFromParent();
//     }
//   }

//   @override
//   void render(Canvas canvas) {
//     final paint = Paint()..color = Colors.yellow;
//     canvas.drawRect(size.toRect(), paint);
//   }

//   @override
//   void onCollision(
//     Set<Vector2> intersectionPoints,
//     PositionComponent other,
//   ) {
//     super.onCollision(intersectionPoints, other);
//     if (other is Enemy) {
//       other.takeDamage(damage);
//       removeFromParent();
//     }
//   }
// }




import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../tower_defense_game.dart';
import 'enemy.dart';

class Bullet extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final Vector2 direction;
  final double speed;
  final double damage;

  Bullet({
    required Vector2 position,
    required this.direction,
    this.speed = 300,
    this.damage = 20,
  }) {
    this.position = position;
    size = Vector2.all(6);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move bullet
    position += direction * speed * dt;

    // Remove if off-screen
    if (position.y < -20 ||
        position.y > gameRef.size.y + 20 ||
        position.x < -20 ||
        position.x > gameRef.size.x + 20) {
      removeFromParent();
      return;
    }

    // Check hit with enemies
    for (final enemy in gameRef.children.whereType<Enemy>()) {
      if (enemy.position.distanceTo(position) < 20) {
        enemy.takeDamage(damage);
        if (enemy.isDead) {
          gameRef.onEnemyKilled();
          enemy.removeFromParent();
        }
        removeFromParent();
        break;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.yellow;
    canvas.drawCircle(Offset.zero, 3, paint);
  }
}