import 'package:flutter/material.dart';

/// Creates [MaterialColor] from a primary color automatically.
/// This should only be used in rare occasions for new themes etc.
///
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

/// Contains all the the themes for the app
class Themes {
  final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFFE3E3E3),
          ),
          elevation: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return 15;
            }
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return 12;
            }
            return 0;
          }),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(
          const Color(0xFFC4E3E5),
        ),
        trackColor: MaterialStateProperty.all(const Color(0xFF7BA0A8)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF8F8F8),
        elevation: 0,
      ),
      // Text theme for light mode
      textTheme: const TextTheme(
        headline2: TextStyle(
            color: Color(0xFF393E46),
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
            fontSize: 40),
        headline3: TextStyle(
          color: Color(0xFF6A7484),
          fontFamily: "Lato",
          fontSize: 26,
        ),
        headline4: TextStyle(
          color: Color(0xFF393E46),
          fontFamily: "Sacramento",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        bodyText1: TextStyle(
            color: Color(0xFF393E46), fontFamily: "Lato", fontSize: 16),
        subtitle1: TextStyle(
            color: Color(0xFF393E46), fontFamily: "Lato", fontSize: 20),
        bodyText2: TextStyle(
            color: Color(0xFF393E46), fontFamily: "Lato", fontSize: 12),
        subtitle2: TextStyle(
            color: Color(0xFF393E46), fontFamily: "Lato", fontSize: 12),
      ),
      primarySwatch: const MaterialColor(
        0xFFE6E6E6,
        <int, Color>{
          50: Color(0xFFFAFAFA),
          100: Color(0xFFF5F5F5),
          200: Color(0xFFEEEEEE),
          300: Color(0xFFE0E0E0),
          350: Color(0xFFD6D6D6),
          400: Color(0xFFBDBDBD),
          500: Color(0xFF9E9E9E),
          600: Color(0xFF757575),
          700: Color(0xFF616161),
          800: Color(0xFF424242),
          850: Color(0xFF303030), // only for background color in dark theme
          900: Color(0xFF212121),
        },
      ));
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF000000),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFF212121),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade800,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
        const Color(0xFFC4E3E5),
      ),
      trackColor: MaterialStateProperty.all(const Color(0xFF7BA0A8)),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.lightBlueAccent),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF333333),
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF333333),
      foregroundColor: Color(0xFFE6E6E6),
    ),
    textTheme: const TextTheme(
      headline2: TextStyle(
        color: Color(0xFFE6E6E6),
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,
        fontSize: 38,
      ),
      headline3: TextStyle(
        color: Color(0xFFC9C9C9),
        fontFamily: "Lato",
        fontWeight: FontWeight.w100,
        fontSize: 26,
      ),
      headline4: TextStyle(
        color: Color(0xFFE6E6E6),
        fontFamily: "Sacramento",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      bodyText1:
          TextStyle(color: Color(0xFFE6E6E6), fontFamily: "Lato", fontSize: 16),
      subtitle1:
          TextStyle(color: Color(0xFFC9C9C9), fontFamily: "Lato", fontSize: 20),
      bodyText2:
          TextStyle(color: Color(0xFFE6E6E6), fontFamily: "Lato", fontSize: 12),
      subtitle2:
          TextStyle(color: Color(0xFFC9C9C9), fontFamily: "Lato", fontSize: 12),
    ),
  );

  Themes();
}
