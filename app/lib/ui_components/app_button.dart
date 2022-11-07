import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  /// Child to be used as button
  final Widget child;

  /// Defines whether the button is enabled. True by default. When false it
  /// reduces the button's opacity.
  final bool isEnabled;

  /// Button's action. When `isEnabled` is false, it does nothing.
  final void Function() onTap;

  const AppButton({
    required this.child,
    required this.onTap,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        elevation: 12,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      child: child,
    );
  }
}
