import 'package:app/pages/game/game_page_vm.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final CardGameState cardGameState;
  const GameCard({
    required this.cardGameState,
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
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        speed: 1000,
        onFlipDone: (status) {
          widget.cardGameState.isFlipped = status;
        },
        front: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF192247),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Center(
            child: Image(
              image: AssetImage('../assets/card_back.png'),
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
