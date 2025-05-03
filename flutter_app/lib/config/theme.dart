import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color accentColor = const Color(0xFF4E45E4);
final Color primary = Colors.white;
final Color secondary = const Color.fromARGB(221, 0, 0, 0);
final Color error = const Color(0xFFE74C3C);

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: primary,
  tertiary: accentColor,
  brightness: Brightness.light,
  primary: Colors.white,
  onPrimary: secondary,
  secondary: secondary,
  onSecondary: primary,
  error: error,
  onError: primary,
  surface: primary,
  onSurface: secondary,
);

extension CustomColors on ColorScheme {
  Color get success => const Color(0xFF2ECC71); // Green
  Color get errorCustom => const Color(0xFFE74C3C); // Red
  Color get warning => const Color(0xFFF39C12); // Orange
  Color get info => const Color(0xFF3498DB);
}

final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: primary,
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
          color: secondary, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: secondary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      selectedItemColor: accentColor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ));
