import 'package:flutter/material.dart';

import '../theme/svg_constants.dart';

class ButtonLogin extends StatelessWidget {
  final String? text;
  final bool login;
  final TextStyle? style;
  final String? forward;
  final bool? otp;
  final Function()? onPressed;

  const ButtonLogin({
    Key? key,
    required this.text,
    this.login = false,
    this.style,
    this.forward,
    required this.otp,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 52,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide.none,
          ),
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!login)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SvgIcon(
                  SvgIcons.google1,
                  size: 18,
                ),
              ),
            if (!login)
              const SizedBox(
                width: 10,
              ),
            Text(
              text!,
              style: style,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
