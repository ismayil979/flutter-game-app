import 'package:flutter/material.dart';
import 'tower_defense_game.dart';

class GameOverOverlay extends StatelessWidget {
  final TowerDefenseGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final title = game.hasWon ? 'You Won!' : 'Game Over';

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.black54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                game.restartGame();
              },
              child: const Text('Play Again'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // back to main menu
              },
              child: const Text('Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}