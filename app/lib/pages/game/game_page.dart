import 'dart:async';

import 'package:app/mvvm/view.abs.dart';
import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/ui_components/game_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class GamePage extends View<GamePageViewModel> {
  const GamePage({required GamePageViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _GamePageState createState() => _GamePageState(viewModel);
}

class _GamePageState extends ViewState<GamePage, GamePageViewModel> {
  _GamePageState(GamePageViewModel viewModel) : super(viewModel);

  late Timer timer;
  int time = 60;
  int moves = 0;
  bool gameStarted = false;
  int previousCardIndex = -1;
  bool flip = false;
  bool flipping = false;

  @override
  void initState() {
    super.initState();
    listenToRoutesSpecs(viewModel.routes);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        time = time - 1;
        if (time < 0) {
          timer.cancel();
          viewModel.navigateToEndPage();
        }
      });
    });
  }

  void onCardFlipped(int index, GamePageState state) {
    setState(() {
      moves++;
      if (!gameStarted) {
        gameStarted = true;
        startTimer();
      }
    });

    if (!flip) {
      flip = true;
      previousCardIndex = index;
    } else {
      flip = false;
      if (previousCardIndex != index) {
        if (state.cards[previousCardIndex].imageURL !=
            state.cards[index].imageURL) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              state.cards[previousCardIndex].cardStateKey.currentState
                  ?.toggleCard();
              state.cards[index].cardStateKey.currentState?.toggleCard();
              previousCardIndex = index;
            });
          });
        } else {
          setState(() {
            state.cards[previousCardIndex].enabled = false;
            state.cards[index].enabled = false;
            state.numOfPairsLeft--;
            previousCardIndex = index;

            if (state.numOfPairsLeft <= 0) {
              viewModel.navigateToEndPage();
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GamePageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final state = snapshot.data!;

        return AbsorbPointer(
          absorbing: flipping,
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Memo Game ${state.gameMode.name} mode'),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Time Left: $time',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'Remaining pairs: ${state.numOfPairsLeft}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Move counter: $moves',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 32),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.cards.length,
                            itemBuilder: (context, index) => GameCard(
                              touchEnabled: state.cards[index].enabled,
                              flipCardKey: state.cards[index].cardStateKey,
                              cardGameState: state.cards[index],
                              flippedCallback: () {
                                onCardFlipped(index, state);
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: state.horizontalAxis,
                              childAspectRatio:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
