import 'package:flutter/material.dart';
import '../utils/pref_utils.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray50 => Color(0xFFF9FAFB);
  Color get gray400 => Color(0xFF9CA3AF);

  // Additional Colors
  Color get whiteCustom => Colors.white;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get colorFFF9F9 => Color(0xFFF9F9F9);
  Color get color140000 => Color(0x14000000);
  Color get colorFF1D19 => Color(0xFF1D1929);
  Color get colorFFF8F7 => Color(0xFFF8F7FF);
  Color get color4C384E => Color(0x4C384EB7);
  Color get colorFF0E0E => Color(0xFF0E0E0E);
  Color get colorFF364A => Color(0xFF364AFF);
  Color get colorFFE8E8 => Color(0xFFE8E8EA);
  Color get colorFFA5A3 => Color(0xFFA5A3A9);
  Color get colorFFE4E4 => Color(0xFFE4E4E4);
  Color get colorFF2323 => Color(0xFF232323);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
