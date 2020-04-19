import 'package:flutter/material.dart';
import 'package:med_app/constants/app_constants.dart';
import 'package:med_app/services/route_generator.dart';
import 'app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteConstants.DefaultScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
