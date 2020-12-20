import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  primaryColorLight: Colors.white24,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  primaryColorDark: Colors.white,
  buttonColor: Color(0xff49c6e6),
);

final lightTheme = ThemeData(
  brightness: WidgetsBinding.instance.window.platformBrightness,

  primarySwatch: Colors.green,
//        primaryColorDark: Color(0xff472DC2),
  primaryColorDark: Colors.green.shade800,
  primaryColor: Colors.green.shade500,
  primaryColorLight: Color(0xff49CC7F),
  buttonColor: Color(0xff49c6e6),
  backgroundColor: Colors.white,
  textTheme: GoogleFonts.manropeTextTheme(),
  appBarTheme: AppBarTheme(color: Colors.white),
  accentColor: Colors.black,
  dividerColor: Colors.white10,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  tabBarTheme:
      TabBarTheme(unselectedLabelColor: Colors.grey, labelColor: Colors.black),
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  bool _isDark = false;
  getTheme() => _themeData;
  isDark() => _isDark;

  setTheme(bool isDarkMode) async {
    _isDark = isDarkMode;
    if (isDarkMode) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }
}

extension CustomColorScheme on ColorScheme {
  Color get success => brightness == Brightness.light
      ? const Color(0xFF28a745)
      : const Color(0x2228a745);
}
