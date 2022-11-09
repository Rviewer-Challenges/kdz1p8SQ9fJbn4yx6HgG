import 'package:app/pages/end/end_page.dart';
import 'package:app/pages/end/end_page_vm.dart';
import 'package:app/pages/game/game_page.dart';
import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/home/home_page_vm.dart';
import 'package:flutter/material.dart';

export 'package:app/mvvm/app_routes.dart';

const String homeRoute = '/';
const String gameRoute = '/game';
const String endRoute = '/end';

class AppRouter {
  Route<dynamic>? route(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>? ?? {};

    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(viewModel: HomePageViewModel()),
        );
      case gameRoute:
        final gameMode = arguments['gameMode'] as GameMode?;

        if (gameMode == null) {
          throw Exception('Route ${settings.name} requires a GameMode');
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => GamePage(
            viewModel: GamePageViewModel(gameMode: gameMode),
          ),
        );
      case endRoute:
        final timeLeft = arguments['timeLeft'] as int?;
        final remainingPairs = arguments['remainingPairs'] as int?;
        final moves = arguments['moves'] as int?;

        if (timeLeft == null || remainingPairs == null || moves == null) {
          throw Exception('Missing arguments for route ${settings.name}');
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => EndPage(
            viewModel: EndPageViewModel(
              timeLeft: timeLeft,
              remainingPairs: remainingPairs,
              moves: moves,
            ),
          ),
        );
      default:
        throw Exception('Route ${settings.name} not implemented');
    }
  }
}
