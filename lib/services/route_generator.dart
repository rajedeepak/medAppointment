import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../home_page.dart';
import '../screens/error_screen/error_screen.dart';
import '../screens/login_screen/login_screen.dart';

MaterialPageRoute _buildPage(dynamic page) {
  return MaterialPageRoute(builder: (_) => page);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.LoginScreen:
        return _buildPage(LoginScreen());

      default:
        return _buildPage(ErrorScreen());
    }
  }
}
