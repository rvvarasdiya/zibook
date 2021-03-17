import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/shared/app_background.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'app_theme_data.dart';
import 'theme_settings_model.dart';

class AppTheme {
  AppTheme.fromData(AppThemeData data) {
    name = data.name ?? "";

    backgroundColors = data.backgroundColors?.map(_colorFromValue)?.toList();

    if (backgroundColors == null || backgroundColors.length < 2) {
      backgroundColors = [Colors.black, const Color(0xff17233d)];
    }

    accentColor = _colorFromValue(data.accentColor) ?? const Color(0xff7263B3);
  }

  /// Returns the currently selected [AppTheme].
  static AppTheme of(BuildContext context) {
    return app.resolve<ThemeSettingsModel>().appTheme;
  }

  /// The name of the theme that is used in the [ThemeCard].
  String name;

  /// A list of colors that define the background gradient.
  ///
  /// The [AppBackground] uses these colors to build the background gradient.
  List<Color> backgroundColors;

  Color get primaryColor => backgroundColors.last;

  /// The accent color should compliment the background color.
  Color accentColor;

  /// Gets the brightness by averaging the relative luminance of each
  /// background color.
  ///
  /// Similar to [ThemeData.estimateBrightnessForColor] for multiple colors.
  Brightness get brightness {
    final double relativeLuminance = backgroundColors
            .map((color) => color.computeLuminance())
            .reduce((a, b) => a + b) /
        backgroundColors.length;

    const double kThreshold = 0.15;

    return ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) >
            kThreshold)
        ? Brightness.light
        : Brightness.dark;
  }

  /// The opposite of [brightness].
  Brightness get complimentaryBrightness =>
      brightness == Brightness.light ? Brightness.dark : Brightness.light;

  /// Returns the [primaryColor] if it is not the same brightness as the button
  /// color, otherwise a complimentary color (white / black).
  Color get buttonTextColor {
    final primaryColorBrightness =
        ThemeData.estimateBrightnessForColor(primaryColor);

    if (brightness == Brightness.dark) {
      // button color is light
      return primaryColorBrightness == Brightness.light
          ? Colors.black
          : primaryColor;
    } else {
      // button color is dark
      return primaryColorBrightness == Brightness.dark
          ? Colors.white
          : primaryColor;
    }
  }

  /// Either [Colors.black] or [Colors.white] depending on the background
  /// brightness.
  ///
  /// This is the color that the text that is written on the background should
  /// have.
  Color get backgroundComplimentaryColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  TextTheme get _textTheme {
    const bodyFont = "Karla";

    final complimentaryColor = backgroundComplimentaryColor;

    return Typography.englishLike2018.apply(fontFamily: bodyFont).copyWith(
          // display

          // title
          title: TextStyle(
            fontSize: (28),
            fontWeight: FontWeight.w700,
            color: appTheme.textColor,
          ),

          subhead: TextStyle(
            fontSize: (24),
            fontWeight: FontWeight.w700,
            color: appTheme.textColor,
          ),

          subtitle: TextStyle(
            height: 1.1,
            fontSize: (22),
            fontWeight: FontWeight.w700,
            color: appTheme.textColor,
          ),

          button: TextStyle(
            fontSize: (18),
            fontWeight: FontWeight.w500,
            color: appTheme.textColor,
          ),
          // body
          body1: TextStyle(
            fontSize: (16),
            fontWeight: FontWeight.w300,
            color: appTheme.textColor,
          ),

          body2: TextStyle(
            fontSize: (16),
            fontWeight: FontWeight.w300,
            color: appTheme.textColor,
          ),

          display4: TextStyle(
            fontSize: (14),
            fontWeight: FontWeight.w500,
            color: ColorConstants.lightFontColor,
          ),
          display3: TextStyle(
            fontSize: (14),
            fontWeight: FontWeight.w300,
            color: ColorConstants.lightFontColor,
          ),

          display2: TextStyle(
            fontSize: (12),
            fontWeight: FontWeight.w500,
            color: ColorConstants.lightFontColor,
          ),
          display1: TextStyle(
            fontSize: (12),
            fontWeight: FontWeight.w300,
            color: ColorConstants.lightFontColor,
          ),
        );
  }

  ThemeData get theme {
    final complimentaryColor = backgroundComplimentaryColor;

    return ThemeData(
      brightness: brightness,
      textTheme: _textTheme,
      primaryColor: primaryColor,
      accentColor: accentColor,
      buttonColor: complimentaryColor,
      fontFamily: "Karla",
      // determines the status bar icon color
      primaryColorBrightness: brightness,
      // used for the background color of material widgets
      cardColor: primaryColor,
      canvasColor: primaryColor,

      // used by toggleable widgets
      toggleableActiveColor: accentColor,

      // used by a textfield when it has focus
      textSelectionHandleColor: accentColor,
    );
  }

  Color _colorFromValue(int value) {
    return value != null ? Color(value) : null;
  }
}

/// The [PredefinedThemes] define [AppTheme]s that can be used as the theme
/// for the app.
///
/// These themes are able to be selected in the [SetupScreen] when a user logs
/// in for the first time and in the [ThemeSettingsScreen].
///
/// Unlike custom themes, the [PredefinedThemes] cannot be deleted.
class PredefinedThemes {
  static List<AppTheme> get themes {
    if (_themes.isEmpty) {
      _themes.addAll(data.map((themeData) => AppTheme.fromData(themeData)));
    }

    return _themes;
  }

  static final List<AppTheme> _themes = [];

  static List<AppThemeData> get data => [light];

  static AppThemeData get light {
    return AppThemeData()
      ..name = "light"
      ..backgroundColors = [Colors.white.value, Colors.white.value]
      ..accentColor = 0xff7263B3;
  }
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
