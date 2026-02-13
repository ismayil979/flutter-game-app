// import 'dart:math';

// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';

// import 'components/enemy.dart';
// import 'components/tower.dart';
// import 'components/pause_button.dart';

// class TowerDefenseGame extends FlameGame
//     with HasCollisionDetection, TapCallbacks {
//   TowerDefenseGame();

//   late Tower tower;

//   int currentLevel = 1;
//   final int maxLevel = 10;

//   final List<int> enemiesPerLevel = [
//     10, 12, 15, 18, 22, 26, 30, 35, 40, 50,
//   ];

//   int enemiesSpawnedThisLevel = 0;
//   int enemiesKilledThisLevel = 0;

//   double _enemySpawnTimer = 0.0;
//   double enemySpawnInterval = 2.0;

//   bool hasWon = false;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();

//     // Tower at bottom center
//     tower = Tower(
//   position: Vector2(size.x / 2, size.y - 80),
// )
//   ..anchor = Anchor.center;
//     add(tower);

//     // Pause button
//     add(
//       PauseButton()
//         ..position = Vector2(size.x - 40, 40)
//         ..anchor = Anchor.center,
//     );

//     _startLevel(currentLevel);
//   }

//   void _startLevel(int level) {
//     enemiesSpawnedThisLevel = 0;
//     enemiesKilledThisLevel = 0;
//     _enemySpawnTimer = 0.0;
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (paused) return;

//     _enemySpawnTimer += dt;

//     // Spawn enemies
//     if (enemiesSpawnedThisLevel < enemiesPerLevel[currentLevel - 1] &&
//         _enemySpawnTimer >= enemySpawnInterval) {
//       _spawnEnemy();
//       _enemySpawnTimer = 0.0;
//     }

//     // Level complete
//     if (enemiesKilledThisLevel >= enemiesPerLevel[currentLevel - 1] &&
//         enemiesPerLevel[currentLevel - 1] > 0) {
//       _onLevelCleared();
//     }
//   }

//   void _spawnEnemy() {
//   enemiesSpawnedThisLevel++;

//   final enemy = Enemy(
//     position: Vector2(Random().nextDouble() * size.x, -20),
//     type: EnemyType.small,
//     getTowerPosition: () => tower.position,
//     onHitTower: (damage) => loseGame(),
//   );

//   add(enemy);
// }

//   void onEnemyKilled() {
//     enemiesKilledThisLevel++;
//   }

//   void _onLevelCleared() {
//     if (currentLevel < maxLevel) {
//       currentLevel++;
//       overlays.add('levelComplete');
//       pauseEngine();
//     } else {
//       hasWon = true;
//       overlays.add('gameOver');
//       pauseEngine();
//     }
//   }

//   void loseGame() {
//     hasWon = false;
//     overlays.add('gameOver');
//     pauseEngine();
//   }

//   void openPauseMenu() {
//     overlays.add('pauseMenu');
//     pauseEngine();
//   }

//   void resumeFromPause() {
//     overlays.remove('pauseMenu');
//     resumeEngine();
//   }

//   void startNextLevel() {
//     overlays.remove('levelComplete');
//     resumeEngine();
//     _startLevel(currentLevel);
//   }

//   void restartGame() {
//     overlays.remove('gameOver');
//     currentLevel = 1;
//     hasWon = false;

//     // ⭐ FIX FOR removeAll() ERROR — this is the correct replacement
//     final allChildren = children.toList();
//     for (final c in allChildren) {
//       c.removeFromParent();
//     }

//     onLoad();
//     resumeEngine();
//   }
// }




import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'components/enemy.dart';
import 'components/tower.dart';
import 'components/pause_button.dart';

class TowerDefenseGame extends FlameGame
    with HasCollisionDetection, TapCallbacks {
  TowerDefenseGame();

  late Tower tower;

  int currentLevel = 1;
  final int maxLevel = 10;

  final List<int> enemiesPerLevel = [
    10, 12, 15, 18, 22, 26, 30, 35, 40, 50,
  ];

  int enemiesSpawnedThisLevel = 0;
  int enemiesKilledThisLevel = 0;

  double _enemySpawnTimer = 0.0;
  double enemySpawnInterval = 2.0;

  bool hasWon = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Tower at bottom center
    tower = Tower(
      position: Vector2(size.x / 2, size.y - 80),
    )..anchor = Anchor.center;
    add(tower);

    // Pause button
    add(
      PauseButton()
        ..position = Vector2(size.x - 40, 40)
        ..anchor = Anchor.center,
    );

    _startLevel(currentLevel);
  }

  void _startLevel(int level) {
    enemiesSpawnedThisLevel = 0;
    enemiesKilledThisLevel = 0;
    _enemySpawnTimer = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (paused) return;

    _enemySpawnTimer += dt;

    // Spawn enemies
    if (enemiesSpawnedThisLevel < enemiesPerLevel[currentLevel - 1] &&
        _enemySpawnTimer >= enemySpawnInterval) {
      _spawnEnemy();
      _enemySpawnTimer = 0.0;
    }

    // Level complete
    if (enemiesKilledThisLevel >= enemiesPerLevel[currentLevel - 1] &&
        enemiesPerLevel[currentLevel - 1] > 0) {
      _onLevelCleared();
    }

    // Tower dead → game over
    if (tower.hp <= 0 && !hasWon) {
      loseGame();
    }
  }

  void _spawnEnemy() {
    enemiesSpawnedThisLevel++;

    final enemy = Enemy(
      position: Vector2(Random().nextDouble() * size.x, -20),
      type: EnemyType.small,
      getTowerPosition: () => tower.position,
      onHitTower: (damage) {
        tower.takeDamage(damage);
      },
    );

    add(enemy);
  }

  void onEnemyKilled() {
    enemiesKilledThisLevel++;
  }

  void _onLevelCleared() {
    if (currentLevel < maxLevel) {
      currentLevel++;
      overlays.add('levelComplete');
      pauseEngine();
    } else {
      hasWon = true;
      overlays.add('gameOver');
      pauseEngine();
    }
  }

  void loseGame() {
    hasWon = false;
    overlays.add('gameOver');
    pauseEngine();
  }

  void openPauseMenu() {
    overlays.add('pauseMenu');
    pauseEngine();
  }

  void resumeFromPause() {
    overlays.remove('pauseMenu');
    resumeEngine();
  }

  void startNextLevel() {
    overlays.remove('levelComplete');
    resumeEngine();
    _startLevel(currentLevel);
  }

  void restartGame() {
    overlays.remove('gameOver');
    currentLevel = 1;
    hasWon = false;

    // Clear all components safely
    final allChildren = children.toList();
    for (final c in allChildren) {
      c.removeFromParent();
    }

    onLoad();
    resumeEngine();
  }
}