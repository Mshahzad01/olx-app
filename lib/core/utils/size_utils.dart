import 'package:flutter/material.dart';

class SizeUtils {
  static final SizeUtils _instance = SizeUtils._internal();
  factory SizeUtils() => _instance;
  SizeUtils._internal();

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static bool _initialized = false;

  static void init(BuildContext context) {
    if (!_initialized) {
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;

      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

      _initialized = true;
    }
  }

  static double getProportionateScreenHeight(double inputHeight) {
    if (!_initialized) {
      throw Exception(
          'SizeUtils not initialized. Call SizeUtils.init() first.');
    }
    return blockSizeVertical * (inputHeight / 8.12);
  }

  static double getProportionateScreenWidth(double inputWidth) {
    if (!_initialized) {
      throw Exception(
          'SizeUtils not initialized. Call SizeUtils.init() first.');
    }
    return blockSizeHorizontal * (inputWidth / 3.75);
  }
}
