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

        return OrientationBuilder(
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
                          'Time Left: 1:00',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Remaining pairs: 0',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Move counter: 0',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 32),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.cards.length,
                          itemBuilder: (context, index) => GameCard(
                            cardGameState: state.cards[index],
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: state.horizontalAxis,
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
      },
    );
  }
}
