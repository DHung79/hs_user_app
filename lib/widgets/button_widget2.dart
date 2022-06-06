import 'package:flutter/material.dart';

class ButtonWidget2 extends StatelessWidget {
  final void Function()? onPressed;
  final TextStyle? style;
  final Color? backgroundColor;
  final String name;
  final BorderSide side;
  const ButtonWidget2({
    Key? key,
    required this.name,
    required this.backgroundColor,
    required this.onPressed,
    required this.style,
    required this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: style,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: side,
          ),
        ),
      ),
    );
  }
}
