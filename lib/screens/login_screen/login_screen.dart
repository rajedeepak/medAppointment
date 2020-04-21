import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/constants/colors_theme.dart';
import 'package:med_app/constants/text_theme.dart';
import 'package:med_app/widgets/my_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _controllerMain;
  AnimationController _controllerSignIn;
  AnimationController _controllerSignUp;

  Animation<double> _animationMain;
  Animation<double> _animationSignIn;
  Animation<double> _animationSignUp;

  @override
  void initState() {
    super.initState();
    _controllerMain = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _controllerSignIn = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _controllerSignUp = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationMain = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: _controllerMain,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _animationSignIn = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: _controllerSignIn,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _animationSignUp = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: _controllerSignUp,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

//    _controllerMain.addListener(() => setState(() {}));
//    _controllerSignIn.addListener(() => setState(() {}));
//    _controllerSignUp.addListener(() => setState(() {}));

    _controllerMain.forward();
//    _controllerSignIn.forward();
//    _controllerSignUp.forward();
  }

  @override
  void dispose() {
    _controllerMain.dispose();
    _controllerSignIn.dispose();
    _controllerSignUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryDark,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              AnimatedBuilder(
                  animation: this._controllerMain,
                  builder: (context, child) {
                    return Positioned(
                      bottom: -30,
                      left: 12,
                      right: 12,
                      child: Transform.translate(
                        offset: Offset(0, _animationMain.value),
                        child: MainLoginWidget(
                          callSignIn: () {
                            this._controllerMain.reverse();
                            this._controllerSignIn.forward();
                          },
                          callSignUp: () {
                            this._controllerMain.reverse();
                            this._controllerSignUp.forward();
                          },
                        ),
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: this._controllerSignIn,
                  builder: (context, child) {
                    return
                      Positioned(
                        bottom: 30,
                        left: 12,
                        right: 12,
                        child: Transform.translate(
                          offset: Offset(0, _animationSignIn.value),
                          child: SignInWidget(onCloseCalled: (){
                            _controllerSignIn.reverse();
                            _controllerMain.forward();
                          }),
                        ),
                      );
                  }),
              AnimatedBuilder(
                  animation: this._controllerSignUp,
                  builder: (context, child) {
                    return Positioned(
                      bottom: 30,
                      left: 12,
                      right: 12,
                      child: Transform.translate(
                        offset: Offset(0, _animationSignUp.value),
                        child: SignUpWidget(onCloseCalled: (){
                          _controllerSignUp.reverse();
                          _controllerMain.forward();
                        }),
                      ),
                    );
                  }),


            ],
          ),
        ),
      ),
    );
  }
}

class MainLoginWidget extends StatelessWidget {
  final Function callSignIn;
  final Function callSignUp;

  const MainLoginWidget({
    Key key,
    @required this.callSignIn,
    @required this.callSignUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(12.0);
    return Material(
      color: AppColors.primaryLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
        side: BorderSide(
          color: AppColors.secondaryLight,
          width: 6,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Welcome to MedApp',
              style: Theme.of(context).textTheme.headline.copyWith(
                    color: Colors.amber,
                    fontSize: 28,
                    fontFamily: AppFont.familyFrederickatheGreat,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyRoundedButton(
                  text: "Sign In",
                  color: AppColors.secondaryAccent,
                  onTap: callSignIn,
                ),
                SizedBox(
                  height: 10,
                ),
                MyRoundedButton(
                  text: "Sign Up",
                  color: AppColors.secondaryAccent,
                  onTap: callSignUp,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  final Function onCloseCalled;

  const SignInWidget({
    Key key,
    @required this.onCloseCalled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(12.0);
    return Material(
      color: AppColors.primaryLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
        side: BorderSide(
          color: AppColors.secondaryLight,
          width: 6,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: AppColors.whiteText,
                        fontFamily: AppFont.familyFrederickatheGreat,
                        fontSize: 30,
                      ),
                ),
                Material(
                  color: AppColors.primaryLight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(200),
                    onTap: onCloseCalled,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.close,
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  final Function onCloseCalled;

  const SignUpWidget({Key key, @required this.onCloseCalled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(12.0);
    return Material(
      color: AppColors.primaryLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
        side: BorderSide(
          color: AppColors.secondaryLight,
          width: 6,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: AppColors.whiteText,
                        fontFamily: AppFont.familyFrederickatheGreat,
                        fontSize: 30,
                      ),
                ),
                Material(
                  color: AppColors.primaryLight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(200),
                    onTap: onCloseCalled,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.close,
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
