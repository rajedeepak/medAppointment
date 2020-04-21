import 'package:flutter/material.dart';
import 'package:med_app/constants/app_constants.dart';
import 'package:med_app/constants/colors_theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: AppColors.primaryLight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Welcome to MedApp',
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white,
                    ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstants.LoginScreen);
                },
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
