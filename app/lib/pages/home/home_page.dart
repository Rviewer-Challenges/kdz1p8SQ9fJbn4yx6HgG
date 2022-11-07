import 'package:app/mvvm/view.abs.dart';
import 'package:app/pages/home/home_page_vm.dart';
import 'package:app/ui_components/app_button.dart';
import 'package:flutter/material.dart';

class HomePage extends View<HomePageViewModel> {
  const HomePage({required HomePageViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _HomePageState createState() => _HomePageState(viewModel);
}

class _HomePageState extends ViewState<HomePage, HomePageViewModel> {
  _HomePageState(HomePageViewModel viewModel) : super(viewModel);

  @override
  void initState() {
    super.initState();
    listenToRoutesSpecs(viewModel.routes);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomePageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Memo Game'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      onTap: viewModel.easyButtonTapped,
                      child: const Text(
                        'Easy Mode (4x4)',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      onTap: viewModel.mediumButtonTapped,
                      child: const Text(
                        'Medium Mode (4x6)',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      onTap: viewModel.hardButtonTapped,
                      child: const Text(
                        'Hard Mode (5x6)',
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
