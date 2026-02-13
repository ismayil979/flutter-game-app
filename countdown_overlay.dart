import 'package:flutter/material.dart';
import 'tower_defense_game.dart';

class CountdownOverlay extends StatelessWidget {
  final TowerDefenseGame game;

  const CountdownOverlay({super.key, required this.game});

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
              'Get Ready!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('countdown');
                game.resumeEngine();
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}