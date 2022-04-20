import 'package:flutter/material.dart';
import 'package:login_bloc/config/theme.dart';
import 'package:login_bloc/config/fonts.dart';

class InputLogin extends StatefulWidget {
  final String hintText;
  final bool? showPassWord;
  final String? text;
  final String email = 'ahihi@gmail.com';
  final TextEditingController? vc;
  final String? Function(String?)? validator;
  const InputLogin({this.vc, Key? key, required this.hintText, this.showPassWord, this.text, this.validator,}) : super(key: key);

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  final TextEditingController _controllerPass = TextEditingController();
  late bool _isObsure = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _controllerPass = TextEditingController();
  //   _controllerAccount = TextEditingController();
  // }

  @override
  void dispose() {
    _controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showPassWord!
        ? Container(
      height: 52,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
      ),
      // padding: const EdgeInsets.only(bottom: 2),
      child: TextFormField(
        cursorHeight: 10,
        cursorColor: Colors.white,
        obscureText: _isObsure,
        autofocus: true,
        style: FontStyle().mainFont,
        validator: widget.validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4)),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.white,),
            onPressed: () {
              setState(() {
                _isObsure = !_isObsure;
              });
            },
          ),
          hintText: widget.hintText,
          filled: true,
          fillColor: ColorApp.secondaryColor3,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3.0, color: ColorApp.secondaryColor3)
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3.0, color: ColorApp.secondaryColor3)
          ),
          hintStyle: FontStyle().mainFont,
        ),
        controller: _controllerPass,

      ),
    )
        : Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: TextFormField(
        validator: widget.validator,
        cursorColor: Colors.white,
        autofocus: true,
        cursorHeight: 10,
        style: FontStyle().mainFont,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: ColorApp.secondaryColor3,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3.0, color: ColorApp.secondaryColor3)
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3.0, color: ColorApp.secondaryColor3)
          ),
          hintStyle: FontStyle().mainFont,
        ),
        controller: widget.vc,
        // onSubmitted: (_email) {
        //   _email = widget.email;
        //   if(widget.vc!.text == _email) {
        //     Navigator.pushNamed(context, '/otp');
        //   } else {
        //   }
        // },
      ),
    );
  }
}
