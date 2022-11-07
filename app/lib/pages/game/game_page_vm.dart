import 'dart:convert';

import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/routes.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

enum GameMode { easy, medium, hard }

enum GameState { loading, running, end }

class GamePageState {
  final GameMode gameMode;
  final GameState gameState;
  final List<String> imagePaths;

  GamePageState({
    this.gameMode = GameMode.easy,
    this.gameState = GameState.loading,
    this.imagePaths = const [],
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
    _initImages();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final images = manifestMap.keys
        .where((key) => key.contains('assets/'))
        .where((key) => key.contains('.png'))
        .where((key) => !key.contains('card_back'))
        .toList();

    _stateSubject
        .add(GamePageState(imagePaths: images, gameState: GameState.running));
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
