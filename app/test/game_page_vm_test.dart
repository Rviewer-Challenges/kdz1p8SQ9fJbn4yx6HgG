import 'dart:async';

import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GamePageViewModel viewModel;

  setUp(() {
    viewModel = GamePageViewModel(gameMode: GameMode.hard);
  });

// This crashes as the ViewModel depends on the context for the assets.
// Mocking would be needed for this test to pass.
  group('GamePageViewModel', () {
    test('Initial state starts with the given hard GameMode', () async {
      final state = await viewModel.state.first;
      expect(state.gameMode, GameMode.hard);
    });

    test('Finishes game and shows correct result', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(() => viewModel.navigateToEndPage(0, 3, 23));
      final route = await viewModel.routes.first;

      expect(route.name, endRoute);
      expect(route.action, AppRouteAction.replaceWith);
      expect(route.arguments, {
        'timeLeft': 0,
        'remainingPairs': 3,
        'moves': 23,
      });

      viewModel.dispose();
    });
  });
}
