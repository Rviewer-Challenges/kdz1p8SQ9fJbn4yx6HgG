import 'dart:async';

import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GamePageViewModel viewModel;

  setUp(() {
    viewModel = GamePageViewModel(gameMode: GameMode.hard);
  });

  group('SecondPageViewModel', () {
    test('initial state starts with the given hard GameMode', () async {
      final state = await viewModel.state.first;
      expect(state.gameMode, GameMode.hard);
    });

    test('thirdPageButtonTapped pushes third page', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.navigateToEndPage);
      final route = await viewModel.routes.first;

      expect(route.name, endRoute);
      expect(route.action, AppRouteAction.pushTo);
      expect(route.arguments, {});

      viewModel.dispose();
    });
  });
}
