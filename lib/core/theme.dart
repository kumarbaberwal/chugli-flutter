import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xff1b202d),
      textTheme: TextTheme(
        titleMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.medium,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.large,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standard,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DefaultColors {
  static const Color greyText = Color(0xffb3b9c6);
  static const Color whiteText = Color(0xffffffff);
  static const Color senderMessage = Color(0xff7a8194);
  static const Color receiverMessage = Color(0xff373e4e);
  static const Color sentMessageInput = Color(0xff3d4354);
  static const Color messageListPage = Color(0xff292f3f);
  static const Color buttonColor = Color(0xff7a8194);
}

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 16.0;
  static const medium = 20.0;
  static const large = 28.0;
}
