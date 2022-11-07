import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/routes.dart';
import 'package:rxdart/subjects.dart';

class EndPageViewModel extends ViewModel {
  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  void popUntilRootButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec.popUntilRoot(),
    );
  }

  void popButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec.pop(),
    );
  }

  void popUntilHomeButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec(name: homeRoute, action: AppRouteAction.popUntil),
    );
  }

  void popUntilSecondButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec(name: gameRoute, action: AppRouteAction.popUntil),
    );
  }

  @override
  void dispose() {
    _routesSubject.close();
  }
}
