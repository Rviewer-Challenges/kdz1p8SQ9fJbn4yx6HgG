import 'package:app/pages/game/game_page_vm.dart';
import 'package:app/ui_components/custom_flip_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final CardGameState cardGameState;
  final VoidCallback? flippedCallback;
  final BoolCallback? doneFlippingCallback;
  final Key flipCardKey;
  final bool touchEnabled;
  const GameCard({
    required this.cardGameState,
    required this.flipCardKey,
    required this.touchEnabled,
    this.flippedCallback,
    this.doneFlippingCallback,
    Key? key,
  }) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0x00000000),
      child: CustomFlipCard(
        flipOnTouch: widget.touchEnabled,
        key: widget.flipCardKey,
        direction: FlipDirection.VERTICAL,
        speed: 300,
        onFlip: widget.flippedCallback,
        onFlipDone: widget.doneFlippingCallback,
        front: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF192247),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/card_back.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        back: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFF192247),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: Image(
              image: AssetImage(widget.cardGameState.imageURL),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
