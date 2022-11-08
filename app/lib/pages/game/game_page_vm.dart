import 'dart:convert';
import 'dart:math';

import 'package:app/mvvm/view_model.abs.dart';
import 'package:app/routes.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

enum GameMode { easy, medium, hard }

enum GameState { loading, running, end }

class CardGameState {
  String imageURL;
  bool enabled = true;
  GlobalKey<FlipCardState> cardStateKey = GlobalKey<FlipCardState>();
  CardGameState(this.imageURL);
}

class GamePageState {
  final GameMode gameMode;
  final GameState gameState;
  final int horizontalAxis;
  final List<CardGameState> cards;
  int numOfPairsLeft;

  GamePageState({
    this.gameMode = GameMode.easy,
    this.horizontalAxis = 4,
    this.gameState = GameState.loading,
    this.cards = const [],
    this.numOfPairsLeft = 0,
  });

  GamePageState copyWith({
    GameMode? gameMode,
    GameState? gameState,
    int? horizontalAxis,
    List<CardGameState>? cards,
    List<GlobalKey<FlipCardState>>? cardStateKeys,
    int? numOfPairsLeft,
  }) {
    return GamePageState(
      gameMode: gameMode ?? this.gameMode,
      gameState: gameState ?? this.gameState,
      horizontalAxis: horizontalAxis ?? this.horizontalAxis,
      cards: cards ?? this.cards,
      numOfPairsLeft: numOfPairsLeft ?? this.numOfPairsLeft,
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

    createGame(images);
  }

  void createGame(List<String> images) {
    final List<CardGameState> cards = [];
    final List<GlobalKey<FlipCardState>> cardStateKeys = [];
    int horizontalAxis = 4;
    int numOfPairs = 0;

    switch (_stateSubject.value.gameMode) {
      case GameMode.easy: // 4x4
        numOfPairs = 8;
        for (var i = 0; i < numOfPairs; i++) {
          final image = images[Random().nextInt(images.length - 1)];
          images.remove(image);
          cards
            ..add(CardGameState(image))
            ..add(CardGameState(image));
        }
        break;
      case GameMode.medium: // 4x6
        numOfPairs = 12;
        for (var i = 0; i < numOfPairs; i++) {
          final image = images[Random().nextInt(images.length - 1)];
          images.remove(image);
          cards
            ..add(CardGameState(image))
            ..add(CardGameState(image));
        }
        break;
      case GameMode.hard: // 5x6
        numOfPairs = 15;
        for (var i = 0; i < numOfPairs; i++) {
          final image = images[Random().nextInt(images.length - 1)];
          images.remove(image);
          cards
            ..add(CardGameState(image))
            ..add(CardGameState(image));
        }
        horizontalAxis = 5;
        break;
    }

    cards.shuffle();

    _stateSubject.add(
      GamePageState(
        cards: cards,
        gameMode: _stateSubject.value.gameMode,
        gameState: GameState.running,
        horizontalAxis: horizontalAxis,
        numOfPairsLeft: numOfPairs,
      ),
    );
  }

  void navigateToEndPage() {
    _routesSubject.add(
      const AppRouteSpec(
        name: endRoute,
        action: AppRouteAction.replaceWith,
      ),
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
    _routesSubject.close();
  }
}
