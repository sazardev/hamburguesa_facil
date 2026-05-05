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

  static TextTheme get _textTheme {
    final base = GoogleFonts.nunitoTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(fontWeight: FontWeight.w800),
      displayMedium: base.displayMedium!.copyWith(fontWeight: FontWeight.w800),
      displaySmall: base.displaySmall!.copyWith(fontWeight: FontWeight.w800),
      headlineLarge: base.headlineLarge!.copyWith(fontWeight: FontWeight.w800),
      headlineMedium:
          base.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
      headlineSmall: base.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
      titleLarge: base.titleLarge!.copyWith(fontWeight: FontWeight.w700),
      titleMedium: base.titleMedium!.copyWith(fontWeight: FontWeight.w600),
      titleSmall: base.titleSmall!.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
      bodyMedium: base.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
      bodySmall: base.bodySmall!.copyWith(fontWeight: FontWeight.w400),
      labelLarge: base.labelLarge!.copyWith(fontWeight: FontWeight.w700),
      labelMedium: base.labelMedium!.copyWith(fontWeight: FontWeight.w700),
      labelSmall: base.labelSmall!.copyWith(fontWeight: FontWeight.w600),
    );
  }

  static final _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;

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
      titleTextStyle: _textTheme.headlineMedium?.copyWith(
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
        textStyle: _textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      labelStyle: _textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: primaryPink.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.all(
        _textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPink,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    textTheme: _textTheme,
    cardTheme: CardThemeData(
      elevation: 4,
      shape: _shape,
      clipBehavior: Clip.hardEdge,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: _textTheme.headlineMedium?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
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
        textStyle: _textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      labelStyle: _textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF2A2A2A),
      indicatorColor: primaryPink.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.all(
        _textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
  );

  void changeTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeThemeMode(
      isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
