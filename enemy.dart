import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

enum EnemyType { small, medium, tank }

class Enemy extends PositionComponent with CollisionCallbacks {
  final EnemyType type;
  final Vector2 Function() getTowerPosition;
  final void Function(double damage) onHitTower;

  late double speed;
  late double maxHp;
  late double hp;
  late double damage;

  bool get isDead => hp <= 0;

  Enemy({
    required Vector2 position,
    required this.type,
    required this.getTowerPosition,
    required this.onHitTower,
  }) {
    this.position = position;
    size = Vector2(30, 30);
    anchor = Anchor.center;
    _configureStats();
  }

  void _configureStats() {
    switch (type) {
      case EnemyType.small:
        speed = 120;
        maxHp = 2;
        damage = 1;
        break;
      case EnemyType.medium:
        speed = 80;
        maxHp = 4;
        damage = 2;
        break;
      case EnemyType.tank:
        speed = 50;
        maxHp = 8;
        damage = 5;
        break;
    }
    hp = maxHp;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    final towerPos = getTowerPosition();
    final dir = (towerPos - position).normalized();
    position += dir * speed * dt;

    if (position.distanceTo(towerPos) < 20) {
      onHitTower(damage);
      removeFromParent();
    }

    if (hp <= 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    Color color;
    switch (type) {
      case EnemyType.small:
        color = Colors.redAccent;
        break;
      case EnemyType.medium:
        color = Colors.orange;
        break;
      case EnemyType.tank:
        color = Colors.purple;
        break;
    }

    final paint = Paint()..color = color;
    canvas.drawRect(size.toRect(), paint);
  }

  void takeDamage(double dmg) {
    hp -= dmg;
  }
}