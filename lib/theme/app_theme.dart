import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF8B4513),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF8B4513),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF8E7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8B4513),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFD2691E),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFD2691E),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    useMaterial3: true,
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
