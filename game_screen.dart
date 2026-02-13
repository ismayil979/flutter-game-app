import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'tower_defense_game.dart';
import 'game_over_overlay.dart';
import 'pause_menu_overlay.dart';
import 'level_complete_overlay.dart';
import 'countdown_overlay.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = TowerDefenseGame();

    return Scaffold(
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'pauseMenu': (context, _) => PauseMenuOverlay(game: game),
          'gameOver': (context, _) => GameOverOverlay(game: game),
          'levelComplete': (context, _) => LevelCompleteOverlay(game: game),
          'countdown': (context, _) => CountdownOverlay(game: game),
        },
        initialActiveOverlays: const ['countdown'],
      ),
    );
  }
}