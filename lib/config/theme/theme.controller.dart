import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  var isDarkTheme = false.obs;

  // ── Kawaii palette ──
  static const Color primaryPink = Color(0xFFFF8FAB);
  static const Color lavender = Color(0xFFC9B1FF);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color cream = Color(0xFFFFF8F0);
  static const Color mintGreen = Color(0xFFA8EDCA);

  ThemeData get themeData => isDarkTheme.value ? _darkTheme : _lightTheme;

  static TextTheme get _textTheme => GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.nunito(fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.nunito(fontWeight: FontWeight.w800),
        headlineLarge: GoogleFonts.nunito(fontWeight: FontWeight.w800),
        headlineMedium: GoogleFonts.nunito(fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.nunito(fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.nunito(fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.nunito(fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.nunito(fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.nunito(fontWeight: FontWeight.w700),
      );

  static final _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPink,
      brightness: Brightness.light,
      primary: primaryPink,
      secondary: lavender,
      tertiary: coral,
      surface: Colors.white,
      surfaceContainerHighest: cream,
    ),
    scaffoldBackgroundColor: cream,
    textTheme: _textTheme,
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: primaryPink.withValues(alpha: 0.3),
      shape: _shape,
      clipBehavior: Clip.hardEdge,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF3D2C35),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF3D2C35)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryPink,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
        shape: _shape,
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      labelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 12),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: primaryPink.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 12),
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPink,
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme,
    cardTheme: CardThemeData(
      elevation: 4,
      shape: _shape,
      clipBehavior: Clip.hardEdge,
    ),
  );

  void changeTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }
}
