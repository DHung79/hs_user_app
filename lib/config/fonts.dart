import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/theme.dart';

class FontStyle {
  TextStyle mainFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w500, color: ColorApp.textColor2);
  TextStyle textFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      color: ColorApp.textColor2,
      fontSize: 14,
      decoration: TextDecoration.underline);
  TextStyle loginFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w700,
    color: ColorApp.purpleColor,
    fontSize: 16,
  );
  TextStyle googleFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w700, color: ColorApp.orangeColor, fontSize: 16);
  TextStyle expService = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.orangeColor, fontSize: 16);
  TextStyle postNow = GoogleFonts.lexend(
      fontWeight: FontWeight.w500, color: ColorApp.orangeColor, fontSize: 14);
  TextStyle noAccountFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      color: ColorApp.secondaryColor3,
      fontSize: 16);
  TextStyle registerFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w700, color: ColorApp.textColor2, fontSize: 16);
  TextStyle errorFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.errorColor, fontSize: 14);
  TextStyle missPassFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor2, fontSize: 24);
  TextStyle errorFont2 = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.errorColor, fontSize: 16);
  TextStyle typeEmailFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor2, fontSize: 14);
  TextStyle sendOTPFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor2, fontSize: 16);
  TextStyle otpTextFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, fontSize: 24, color: ColorApp.textColor2);
  TextStyle titleFontService = GoogleFonts.lexend(
      fontWeight: FontWeight.w500, color: ColorApp.purpleColor, fontSize: 16);
  TextStyle topNavActive = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.purpleColor, fontSize: 14);
  TextStyle topNavNotActive = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor1, fontSize: 14);
  TextStyle serviceFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w500, color: ColorApp.textColor1, fontSize: 16);
  TextStyle textInPostTask = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor1, fontSize: 14);
  TextStyle textHelloContent = GoogleFonts.lexend(
    fontWeight: FontWeight.w400,
    color: const Color.fromRGBO(128, 148, 159, 1),
    fontSize: 14,
  );
  TextStyle timeDeleteTask = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, color: ColorApp.textColor6, fontSize: 14);
  TextStyle statusFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w500,
      color: const Color.fromRGBO(102, 199, 25, 1),
      fontSize: 14);
}
