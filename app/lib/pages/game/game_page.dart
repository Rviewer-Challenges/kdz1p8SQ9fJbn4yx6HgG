import 'dart:math';

import 'package:app/mvvm/view.abs.dart';
import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/ui_components/app_button.dart';
import 'package:app/ui_components/game_card.dart';
import 'package:flutter/material.dart';

class GamePage extends View<GamePageViewModel> {
  const GamePage({required GamePageViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _GamePageState createState() => _GamePageState(viewModel);
}

class _GamePageState extends ViewState<GamePage, GamePageViewModel> {
  _GamePageState(GamePageViewModel viewModel) : super(viewModel);

  @override
  void initState() {
    super.initState();
    listenToRoutesSpecs(viewModel.routes);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GamePageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final state = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Game Page'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''You have selected the difficulty ${state.gameMode} in the previous page''',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '''Game State -> ${state.gameState}''',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    GameCard(
                      cardImage: state.imagePaths[
                          Random().nextInt(state.imagePaths.length - 1)],
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      onTap: viewModel.thirdPageButtonTapped,
                      child: Text(
                        'Go to end page',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
