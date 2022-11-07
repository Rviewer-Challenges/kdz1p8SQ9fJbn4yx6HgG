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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popUntilRootButtonTapped,
                  child: Text(
                    'Pop until root',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popUntilHomeButtonTapped,
                  child: Text(
                    'Pop until home page',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popUntilSecondButtonTapped,
                  child: Text(
                    'Pop until second page',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popButtonTapped,
                  child: Text(
                    'Pop',
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
  }
}
