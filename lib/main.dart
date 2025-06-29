import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF607D8B));

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color(0xFF90A4AE),
);

ThemeData buildTheme(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme().copyWith(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
    cardTheme: CardThemeData().copyWith(
      color: colorScheme.primaryContainer,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(color: colorScheme.onSurface),
      bodySmall: GoogleFonts.poppins(color: colorScheme.onSurface),
      titleLarge: GoogleFonts.poppins(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker App',
      darkTheme: buildTheme(kDarkColorScheme),
      theme: buildTheme(kColorScheme),
      themeMode: ThemeMode.dark,
      home: Expenses(),
    ),
  );
}
