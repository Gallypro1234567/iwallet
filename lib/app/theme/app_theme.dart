// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() {
    return _instance;
  }
  AppTheme._internal();

  // fonts
  static const String Roboto = "Roboto";
  static const String defaultFont = Roboto;
  // colors
  static const Color primaryColor = Color(0xff0061fe);
  static const Color backgroundWhiteColor = Color(0xfff2f2f2);
  static const Color backgroundDarkGreyColor = Color(0xff282828);
  // themes
  static ThemeData darkTheme = ThemeData(
    fontFamily: defaultFont,
    appBarTheme: AppBarTheme(
      titleTextStyle:
          const CupertinoTextThemeData().textStyle.copyWith(fontSize: 18),
      backgroundColor: const ColorScheme.dark().background,
      foregroundColor: Colors.white,
      shadowColor: null,
    ),
    canvasColor: const ColorScheme.dark().background,
    scaffoldBackgroundColor: const ColorScheme.dark().background,
    cardColor: backgroundDarkGreyColor,
    dividerColor: const ColorScheme.dark().onSurface.withOpacity(0.12),
    dialogBackgroundColor: const ColorScheme.dark().background,
    applyElevationOverlayColor: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    dialogTheme: DialogTheme(
      backgroundColor: const ColorScheme.dark().surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const ColorScheme.dark().surface,
      shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.8,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppTheme.primaryColor,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: defaultFont,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle:
          const CupertinoTextThemeData().textStyle.copyWith(fontSize: 18),
      backgroundColor: const ColorScheme.light().background,
      foregroundColor: Colors.black,
      shadowColor: const ColorScheme.light().onSurface.withOpacity(0.2),
    ),
    canvasColor: backgroundWhiteColor,
    scaffoldBackgroundColor: backgroundWhiteColor,
    cardColor: const ColorScheme.light().surface,
    dividerColor: const ColorScheme.light().onSurface.withOpacity(0.12),
    dialogBackgroundColor: const ColorScheme.light().background,
    applyElevationOverlayColor: false,
    dialogTheme: DialogTheme(
      backgroundColor: const ColorScheme.light().surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const ColorScheme.light().surface,
      shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.8,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppTheme.primaryColor,
      disabledColor: Colors.grey,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: const CircularNotchedRectangle(),
      color: const ColorScheme.light().surface,
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppTheme.primaryColor,
      error: const ColorScheme.light().error,
      background: backgroundWhiteColor,
    ),
  );
}
