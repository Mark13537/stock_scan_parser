import 'package:flutter/material.dart';

abstract class AppTheme {
  static AppTheme of(BuildContext context) => DarkModeTheme();

  AppTypography get typography => ThemeTypography(this);

  Color get primary;
  Color get secondary;
  Color get tertiary;
  Color get onPrimary;
  Color get onSecondary;
  Color get bullishGreen;
  Color get bearishRed;
  Color get link;
  Color get error;
  Color get onError;

  TextStyle get labelSmall => typography.labelSmall;
  TextStyle get labelMedium => typography.labelMedium;
  TextStyle get labelLarge => typography.labelLarge;
}

abstract class AppTypography {
  TextStyle get labelSmall;
  TextStyle get labelMedium;
  TextStyle get labelLarge;
}

class DarkModeTheme extends AppTheme {
  @override
  Color get primary => const Color(0xFF000000);

  @override
  Color get secondary => const Color(0xFFFFFFFF);

  @override
  Color get tertiary => const Color(0xFFADD8E6);

  @override
  Color get onPrimary => const Color(0xFFFFFFFF);

  @override
  Color get onSecondary => const Color(0xFF000000);

  @override
  Color get bullishGreen => const Color(0xFF00FF00);

  @override
  Color get bearishRed => const Color(0xFFFF0000);

  @override
  Color get link => const Color(0xFF0000FF);

  @override
  Color get error => const Color(0xFFFF0000);

  @override
  Color get onError => const Color(0xFFFFFFFF);
}

class ThemeTypography extends AppTypography {
  ThemeTypography(this.appTheme);

  final AppTheme appTheme;

  @override
  TextStyle get labelLarge => TextStyle(
        color: appTheme.onPrimary,
        fontSize: 16.0,
      );

  @override
  TextStyle get labelMedium => TextStyle(
        color: appTheme.onPrimary,
        fontSize: 10.0,
      );

  @override
  TextStyle get labelSmall => TextStyle(
        color: appTheme.onPrimary,
        fontSize: 6.0,
      );
}
