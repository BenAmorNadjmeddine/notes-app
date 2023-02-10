import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/Shared/Style/colors.dart';
import 'package:notes_app/Shared/Style/fonts.dart';

import 'styles.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: font!,
  scaffoldBackgroundColor: scaffoldBackgroundLightColor,
  primarySwatch: primarySwatch,
  appBarTheme: AppBarTheme(
    backgroundColor: scaffoldBackgroundLightColor,
    elevation: 0.0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: scaffoldBackgroundLightColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: scaffoldBackgroundDarkColor),
    titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: scaffoldBackgroundDarkColor),
  ),
  iconTheme: IconThemeData(color: scaffoldBackgroundDarkColor, size: 22.0),
  textTheme: TextTheme(
    displayLarge: lightDisplayLarge,
    displayMedium: lightDisplayMedium,
    displaySmall: lightDisplaySmall,
    headlineLarge: lightHeadlineLarge,
    headlineMedium: lightHeadlineMedium,
    headlineSmall: lightHeadlineSmall,
    titleLarge: lightTitleLarge,
    titleMedium: lightTitleMedium,
    titleSmall: lightTitleSmall,
    bodyLarge: lightBodyLarge,
    bodyMedium: lightBodyMedium,
    bodySmall: lightBodySmall,
    labelLarge: lightLabelLarge,
    labelMedium: lightLabelMedium,
    labelSmall: lightLabelSmall,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    extendedTextStyle: TextStyle(
      fontSize: 17.0,
      color: scaffoldBackgroundLightColor,
      fontWeight: FontWeight.w700,
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: scaffoldBackgroundDarkColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  drawerTheme: DrawerThemeData(backgroundColor: scaffoldBackgroundLightColor),
);

ThemeData darkTheme = ThemeData(
  fontFamily: font!,
  scaffoldBackgroundColor: scaffoldBackgroundDarkColor,
  primarySwatch: primarySwatch,
  appBarTheme: AppBarTheme(
    backgroundColor: scaffoldBackgroundDarkColor,
    elevation: 0.0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: scaffoldBackgroundDarkColor,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: scaffoldBackgroundLightColor),
    titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: scaffoldBackgroundLightColor),
  ),
  iconTheme: IconThemeData(color: scaffoldBackgroundLightColor, size: 22.0),
  textTheme: TextTheme(
    displayLarge: darkDisplayLarge,
    displayMedium: darkDisplayMedium,
    displaySmall: darkDisplaySmall,
    headlineLarge: darkHeadlineLarge,
    headlineMedium: darkHeadlineMedium,
    headlineSmall: darkHeadlineSmall,
    titleLarge: darkTitleLarge,
    titleMedium: darkTitleMedium,
    titleSmall: darkTitleSmall,
    bodyLarge: darkBodyLarge,
    bodyMedium: darkBodyMedium,
    bodySmall: darkBodySmall,
    labelLarge: darkLabelLarge,
    labelMedium: darkLabelMedium,
    labelSmall: darkLabelSmall,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    extendedTextStyle: TextStyle(
      fontSize: 17.0,
      color: scaffoldBackgroundLightColor,
      fontWeight: FontWeight.w700,
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: scaffoldBackgroundLightColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  drawerTheme: DrawerThemeData(backgroundColor: scaffoldBackgroundDarkColor),
);
