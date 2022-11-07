import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final String cardImage;
  const GameCard({
    required this.cardImage,
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
      margin: const EdgeInsets.all(8),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        speed: 1000,
        onFlipDone: (status) {
          if (kDebugMode) {
            print(status);
          }
        },
        front: SizedBox(
          width: 200,
          height: 275,
          child: Container(
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
        ),
        back: SizedBox(
          width: 200,
          height: 275,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF192247),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Image(
                image: AssetImage(widget.cardImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
