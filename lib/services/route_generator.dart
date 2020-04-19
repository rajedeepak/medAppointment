import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/app.dart';
import 'package:med_app/constants/app_constants.dart';
import '../screens/error_screen/error_screen.dart';

MaterialPageRoute _buildPage(dynamic page) {
  return MaterialPageRoute(builder: (_) => page);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.DefaultScreen:
        return _buildPage(MyHomePage());
      default:
        return _buildPage(ErrorScreen());
    }
  }
}
