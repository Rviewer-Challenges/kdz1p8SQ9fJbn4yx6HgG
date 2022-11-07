import 'dart:async';

import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/pages/home/home_page_vm.dart';
import 'package:app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomePageViewModel viewModel;

  setUp(() {
    viewModel = HomePageViewModel();
  });

  group('HomePageViewModel', () {
    test('initial state starts with GameMode in easy', () async {
      final state = await viewModel.state.first;

      expect(state.gameMode, GameMode.easy);
    });

    test('GameMode changes to medium if medium', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.mediumButtonTapped);
      final route = await viewModel.routes.first;
      final state = await viewModel.state.first;

      expect(state.gameMode, GameMode.medium);
      expect(route.name, gameRoute);
      expect(route.action, AppRouteAction.pushTo);
      expect(route.arguments, {'gameMode': GameMode.medium});

      viewModel.dispose();
    });
  });
}
