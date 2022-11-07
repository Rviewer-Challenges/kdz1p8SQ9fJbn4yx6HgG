import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/routes.dart';
import 'package:rxdart/subjects.dart';

class HomePageState {
  late final GameMode gameMode;

  HomePageState({this.gameMode = GameMode.easy});

  HomePageState copyWith({
    GameMode? gameMode,
  }) {
    return HomePageState(
      gameMode: gameMode ?? this.gameMode,
    );
  }
}

class HomePageViewModel extends ViewModel {
  final _stateSubject = BehaviorSubject<HomePageState>.seeded(HomePageState());
  Stream<HomePageState> get state => _stateSubject;

  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  void easyButtonTapped() {
    _updateState(GameMode.easy);
    routeToGamePage();
  }

  void mediumButtonTapped() {
    _updateState(GameMode.medium);
    routeToGamePage();
  }

  void hardButtonTapped() {
    _updateState(GameMode.hard);
    routeToGamePage();
  }

  void routeToGamePage() {
    _routesSubject.add(
      AppRouteSpec(
        name: gameRoute,
        arguments: {
          'gameMode': _stateSubject.value.gameMode,
        },
      ),
    );
  }

  void _updateState(GameMode gameMode) {
    final state = _stateSubject.value;
    _stateSubject.add(
      state.copyWith(
        gameMode: gameMode,
      ),
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
    _routesSubject.close();
  }
}
