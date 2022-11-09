import 'dart:async';

import 'package:app/pages/end/end_page_vm.dart';
import 'package:app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EndPageViewModel viewModel;

  setUp(() {
    viewModel = EndPageViewModel(timeLeft: 20, remainingPairs: 0, moves: 8);
  });

  group('EndPageViewModel', () {
    test('Restart goes to home', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.restartButtonTapped);
      final route = await viewModel.routes.first;

      expect(route.name, '');
      expect(route.action, AppRouteAction.popUntilRoot);
      expect(route.arguments, {});

      viewModel.dispose();
    });
  });
}
