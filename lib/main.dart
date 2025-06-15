import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(1, 44, 189, 187),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(1, 17, 25, 24),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker App',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: kDarkColorScheme.secondaryContainer,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyLarge: GoogleFonts.poppins(color: kDarkColorScheme.onSurface),
          bodySmall: GoogleFonts.poppins(color: kDarkColorScheme.onSurface),
          titleLarge: GoogleFonts.poppins(
            color: kDarkColorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kColorScheme.secondaryContainer, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyLarge: GoogleFonts.poppins(color: kColorScheme.onSurface),
          bodySmall: GoogleFonts.poppins(color: kColorScheme.onSurface),
          titleLarge: GoogleFonts.poppins(
            color: kColorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: Expenses(),
    ),
  );
}
