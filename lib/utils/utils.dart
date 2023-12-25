import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';

class Utils {
  static Dio get dioInstance {
    final dioInstance = Dio();
    dioInstance.options.followRedirects = false;
    dioInstance.options.validateStatus = (status) => status! <= 500;
    dioInstance.options.responseType = ResponseType.json;

    return dioInstance;
  }

  static Color getTagColor(final BuildContext context, final String color) {
    switch (color) {
      case 'green':
        return AppTheme.of(context).bullishGreen;
      case 'red':
        return AppTheme.of(context).bearishRed;
      default:
        return AppTheme.of(context).onPrimary;
    }
  }

  static ScaffoldFeatureController showInSnackBar(
      final BuildContext context, final String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
