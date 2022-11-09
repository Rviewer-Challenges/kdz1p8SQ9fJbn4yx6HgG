import 'package:app/mvvm/view.abs.dart';
import 'package:app/pages/end/end_page_vm.dart';
import 'package:app/ui_components/app_button.dart';
import 'package:flutter/material.dart';

class EndPage extends View<EndPageViewModel> {
  const EndPage({required EndPageViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _EndPageState createState() => _EndPageState(viewModel);
}

class _EndPageState extends ViewState<EndPage, EndPageViewModel> {
  _EndPageState(EndPageViewModel viewModel) : super(viewModel);

  @override
  void initState() {
    super.initState();
    listenToRoutesSpecs(viewModel.routes);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EndPageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final state = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Results'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.remainingPairs == 0 ? 'You Win!' : 'You Lose!',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Time Left: ${state.timeLeft}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'Remaining pairs: ${state.remainingPairs}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Move counter: ${state.moves}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      onTap: viewModel.restartButtonTapped,
                      child: Text(
                        'Restart',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 32),
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
