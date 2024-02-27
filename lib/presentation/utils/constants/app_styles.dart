import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // App Theme
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  ).copyWith(
    textTheme: TextTheme(
      titleLarge: const TextStyle(color: Colors.black87),
      headlineSmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87)),
      titleSmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87)),
      bodyMedium: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: 13, color: Colors.black87)),
      bodySmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87)),
      displaySmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
      displayMedium: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  ).copyWith(
    textTheme: TextTheme(
      titleLarge: const TextStyle(color: Colors.white),
      headlineSmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      titleSmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
      bodyMedium: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: 13, color: Colors.white)),
      bodySmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
      displaySmall: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
      displayMedium: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  // Text Styles
  static const TextStyle smallTextStyle = TextStyle(fontSize: 14);
  static const TextStyle bigTextStyle = TextStyle(fontSize: 18);
  static const TextStyle extraBigTextStyle = TextStyle(fontSize: 22);

  static BoxDecoration getDecorationPoster() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          )
        ]);
  }
}
