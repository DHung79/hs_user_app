import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_services/config/theme.dart';

class FontStyle {
  TextStyle mainFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w500, color: ColorApp.textColor2);
  TextStyle textFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      color: ColorApp.textColor2,
      fontSize: 14,
      decoration: TextDecoration.underline);
  TextStyle statusFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w500,
    color: const Color.fromRGBO(102, 199, 25, 1),
    fontSize: 14,
  );
  TextStyle postTimeFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w400,
    color: const Color.fromRGBO(157, 179, 192, 1),
    fontSize: 14,
  );
  TextStyle loginFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w700,
    color: ColorApp.purpleColor,
    fontSize: 16,
  );
  TextStyle titleFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w500,
    color: ColorApp.purpleColor,
    fontSize: 16,
  );
  TextStyle Tasked = GoogleFonts.lexend(
    fontWeight: FontWeight.w500,
    color: ColorApp.textColor1,
    fontSize: 16,
  );
  TextStyle lineFont = GoogleFonts.lexend(
    fontWeight: FontWeight.w400,
    color: ColorApp.purpleColor,
    fontSize: 14,
  );
  TextStyle googleFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w700, color: ColorApp.orangeColor, fontSize: 16);
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
  TextStyle textTitleFont = GoogleFonts.lexend(
      fontWeight: FontWeight.w400, fontSize: 14, color: ColorApp.textColor1);
}
