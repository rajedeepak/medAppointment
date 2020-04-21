import 'package:flutter/material.dart';
import 'package:med_app/constants/app_constants.dart';
import 'package:med_app/services/route_generator.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: RouteConstants.DefaultScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: _getTheme(context),
    );
  }
}

ThemeData _getTheme(BuildContext context) {
  return ThemeData();
}