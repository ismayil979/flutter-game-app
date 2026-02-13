import 'package:flutter/material.dart';
import 'tower_defense_game.dart';

class LevelCompleteOverlay extends StatelessWidget {
  final TowerDefenseGame game;

  const LevelCompleteOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.black54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Level ${game.currentLevel - 1} Complete!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Next: Level ${game.currentLevel}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                game.startNextLevel();
              },
              child: const Text('Next Level'),
            ),
          ],
        ),
      ),
    );
  }
}