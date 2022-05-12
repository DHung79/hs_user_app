import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/theme.dart';

class AppTextTheme {
  mediumBigText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: color,
    );
  }

  bigText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: color,
    );
  }

  headerAndTitle(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: color,
    );
  }

  mediumHeaderAndTitle(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: color,
    );
  }

  normalHeaderAndTitle(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: color,
    );
  }

  boldBodyText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: color,
    );
  }

  mediumBodyText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: color,
    );
  }

  normalText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: color,
    );
  }

  subText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: color,
    );
  }

  superSmallText(Color color) {
    return GoogleFonts.lexend(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: color,
    );
  }
}
