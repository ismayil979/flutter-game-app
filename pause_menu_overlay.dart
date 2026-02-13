import 'package:flutter/material.dart';
import 'tower_defense_game.dart';

class PauseMenuOverlay extends StatelessWidget {
  final TowerDefenseGame game;

  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.black54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paused',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                game.resumeFromPause();
              },
              child: const Text('Resume'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // back to main menu
              },
              child: const Text('Quit to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}