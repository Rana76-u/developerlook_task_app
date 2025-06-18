import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:flutter/material.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline26Bold => TextStyle(
        fontSize: 26.fSize,
        fontWeight: FontWeight.w700,
        color: appTheme.colorFF1D19,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title16Bold => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
        color: appTheme.colorFF0E0E,
      );

  TextStyle get title16SemiBold => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.colorFF0E0E,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14Regular => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.colorFFA5A3,
      );

  TextStyle get body14Bold => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
        color: appTheme.whiteCustom,
      );
}
