import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CustomFlipCard extends FlipCard {
  const CustomFlipCard({
    required super.front,
    required super.back,
    Key? key,
    super.speed = 500,
    super.onFlip,
    super.onFlipDone,
    super.direction = FlipDirection.HORIZONTAL,
    super.controller,
    super.flipOnTouch = true,
    super.alignment = Alignment.center,
    super.fill = Fill.none,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomFlipCardState();
  }
}

class CustomFlipCardState extends FlipCardState {
  Animation<double>? _frontRotation;
  Animation<double>? _backRotation;

  @override
  void initState() {
    super.initState();
    _frontRotation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.toDouble(), end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50,
        ),
      ],
    ).animate(controller!);
    _backRotation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.toDouble())
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
      ],
    ).animate(controller!);
  }

  //Disable callback when toggling the card programatically
  @override
  void toggleCard() {
    controller!.duration = Duration(milliseconds: widget.speed);
    if (isFront) {
      controller!.forward();
    } else {
      controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final frontPositioning = widget.fill == Fill.fillFront ? _fill : _noop;
    final backPositioning = widget.fill == Fill.fillBack ? _fill : _noop;

    final child = Stack(
      alignment: widget.alignment,
      fit: StackFit.passthrough,
      children: <Widget>[
        frontPositioning(_buildContent(front: true)),
        backPositioning(_buildContent(front: false)),
      ],
    );

    /// if we need to flip the card on taps, wrap the content
    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.onFlip!();
          toggleCard();
        },
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({required bool front}) {
    /// pointer events that would reach the backside of the card should be
    /// ignored
    return IgnorePointer(
      /// absorb the front card when the background is active (!isFront),
      /// absorb the background when the front is active
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        direction: widget.direction,
        child: front ? widget.front : widget.back,
      ),
    );
  }
}

Widget _fill(Widget child) => Positioned.fill(child: child);
Widget _noop(Widget child) => child;
