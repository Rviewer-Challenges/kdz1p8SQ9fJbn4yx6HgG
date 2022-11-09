import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/routes.dart';
import 'package:rxdart/subjects.dart';

class EndPageState {
  final int timeLeft;
  final int remainingPairs;
  final int moves;

  EndPageState({
    this.timeLeft = 0,
    this.remainingPairs = 0,
    this.moves = 0,
  });

  EndPageState copyWith({int? timeLeft, int? remainingPairs, int? moves}) {
    return EndPageState(
      timeLeft: timeLeft ?? this.timeLeft,
      remainingPairs: remainingPairs ?? this.remainingPairs,
      moves: moves ?? this.moves,
    );
  }
}

class EndPageViewModel extends ViewModel {
  final _stateSubject = BehaviorSubject<EndPageState>.seeded(EndPageState());
  Stream<EndPageState> get state => _stateSubject;

  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  EndPageViewModel({
    required int timeLeft,
    required int remainingPairs,
    required int moves,
  }) {
    _stateSubject.add(
      EndPageState(
        timeLeft: timeLeft,
        remainingPairs: remainingPairs,
        moves: moves,
      ),
    );
  }

  void restartButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec.popUntilRoot(),
    );
  }

  @override
  void dispose() {
    _routesSubject.close();
  }
}
