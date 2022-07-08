import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../../theme/svg_constants.dart';

// ignore: must_be_immutable
class AppbarSearch extends StatefulWidget {
  final TextEditingController controller;
  bool? haveData;
  final void Function()? onPressed;
  final List<Widget>? actions;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  AppbarSearch({
    Key? key,
    this.haveData,
    required this.onPressed,
    required this.controller,
    this.actions,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<AppbarSearch> createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 16,
      shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      toolbarHeight: 80.0,
      actions: widget.actions,
      leading: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, minimumSize: const Size(24, 24)),
        onPressed: widget.onPressed,
        child: SvgIcon(
          SvgIcons.arrowBack,
          size: 24,
          color: AppColor.text1,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: TextField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                widget.haveData = true;
              });
            }
          },
          cursorColor: AppColor.text7,
          controller: widget.controller,
          style: AppTextTheme.normalText(AppColor.text1),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintText: 'Tìm kiếm vị trí',
            hintStyle: AppTextTheme.normalText(AppColor.text7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.text7,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.text7,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.text7,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.haveData! ? AppColor.primary1 : AppColor.text7,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
