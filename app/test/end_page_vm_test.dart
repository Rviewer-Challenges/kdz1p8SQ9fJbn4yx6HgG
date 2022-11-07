import 'dart:async';

import 'package:app/pages/end/end_page_vm.dart';
import 'package:app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EndPageViewModel viewModel;

  setUp(() {
    viewModel = EndPageViewModel();
  });

  group('ThirdPageViewModel', () {
    test('popUntilRootButtonTapped pops to root', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.popUntilRootButtonTapped);
      final route = await viewModel.routes.first;

      expect(route.name, '');
      expect(route.action, AppRouteAction.popUntilRoot);
      expect(route.arguments, {});

      viewModel.dispose();
    });

    test('popButtonTapped pops page', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.popButtonTapped);
      final route = await viewModel.routes.first;

      expect(route.name, '');
      expect(route.action, AppRouteAction.pop);
      expect(route.arguments, {});

      viewModel.dispose();
    });

    test('popUntilHomeButtonTapped pops page', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.popUntilHomeButtonTapped);
      final route = await viewModel.routes.first;

      expect(route.name, '/');
      expect(route.action, AppRouteAction.popUntil);
      expect(route.arguments, {});

      viewModel.dispose();
    });

    test('popUntilSecondButtonTapped pops page', () async {
      // delay execution so the event it caught by the Routes Publish
      scheduleMicrotask(viewModel.popUntilSecondButtonTapped);
      final route = await viewModel.routes.first;

      expect(route.name, gameRoute);
      expect(route.action, AppRouteAction.popUntil);
      expect(route.arguments, {});

      viewModel.dispose();
    });
  });
}
