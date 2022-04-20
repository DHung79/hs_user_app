import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonLogin extends StatelessWidget {
  final String? text;
  final bool login;
  final TextStyle? style;
  final String? forward;
  final bool? otp;
  void Function()? onPressed;

  String email = 'ahihi@gmail.com';

  ButtonLogin(
      {Key? key,
      required this.text,
      this.login = false,
      this.style,
      this.forward,
      required this.otp,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 52,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), side: BorderSide.none),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!login)
              SvgPicture.asset(
                'assets/icons/27717.svg',
                height: 24,
                width: 24,
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
