import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/pages/home/home_page_vm.dart';
import 'package:app/routes.dart';
import 'package:rxdart/subjects.dart';

class GamePageState {
  final GameMode gameMode;

  GamePageState({
    this.gameMode = GameMode.easy,
  });

  GamePageState copyWith({
    GameMode? gameMode,
  }) {
    return GamePageState(
      gameMode: gameMode ?? this.gameMode,
    );
  }
}

class GamePageViewModel extends ViewModel {
  final _stateSubject = BehaviorSubject<GamePageState>.seeded(GamePageState());
  Stream<GamePageState> get state => _stateSubject;

  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  GamePageViewModel({required GameMode gameMode}) {
    _stateSubject.add(GamePageState(gameMode: gameMode));
  }

  void thirdPageButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec(name: endRoute),
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
    _routesSubject.close();
  }
}
