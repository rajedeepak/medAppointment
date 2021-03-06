import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:med_app/constants/colors_theme.dart';
import 'package:med_app/constants/text_theme.dart';
import 'package:med_app/utilities.dart';
import 'package:med_app/widgets/my_buttons.dart';

enum _Panels { main, signIn, signUp, forget }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _controllerMain;
  AnimationController _controllerSignIn;
  AnimationController _controllerSignUp;
  AnimationController _controllerForgotPassword;

  Animation<double> _animationMain;
  Animation<double> _animationSignIn;
  Animation<double> _animationSignUp;
  Animation<double> _animationForgotPassword;

  bool keyboardActive = false;
  bool doubleBackToExitState = false;

  List<_Panels> _activePanelList;

  int secondsToExit = 2;

  @override
  void initState() {
    super.initState();

    _activePanelList = <_Panels>[_Panels.main];

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

    _controllerForgotPassword = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationMain = Tween<double>(begin: 700, end: 0).animate(
      CurvedAnimation(
        parent: _controllerMain,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _animationSignIn = Tween<double>(begin: 700, end: 0).animate(
      CurvedAnimation(
        parent: _controllerSignIn,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _animationSignUp = Tween<double>(begin: 700, end: 0).animate(
      CurvedAnimation(
        parent: _controllerSignUp,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _animationForgotPassword = Tween<double>(begin: 700, end: 0).animate(
      CurvedAnimation(
        parent: _controllerForgotPassword,
        curve: Interval(0.4, 1, curve: Curves.easeInOutCubic),
      ),
    );

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      if (visible)
        keyboardActive = true;
      else
        keyboardActive = false;
    });

    _controllerMain.forward();
  }

  @override
  void dispose() {
    _controllerMain.dispose();
    _controllerSignIn.dispose();
    _controllerSignUp.dispose();
    _controllerForgotPassword.dispose();
    super.dispose();
  }

  void _pushSignIn() {
    this._controllerMain.reverse();
    this._controllerSignIn.forward();
    _activePanelList.add(_Panels.signIn);
  }

  void _removeSignIn() {
    FocusScope.of(context).unfocus();
    _activePanelList.removeLast();
    _controllerSignIn.reverse();
    _controllerMain.forward();
  }

  void _pushSignUp() {
    this._controllerMain.reverse();
    this._controllerSignUp.forward();
    _activePanelList.add(_Panels.signUp);
  }

  void _removeSignUp() {
    FocusScope.of(context).unfocus();
    _activePanelList.removeLast();
    _controllerSignUp.reverse();
    _controllerMain.forward();
  }

  void _pushForgetPassword() {
    _controllerSignIn.reverse();
    _controllerForgotPassword.forward();
    _activePanelList.add(_Panels.forget);
  }

  void _removeForgetPassword() {
    FocusScope.of(context).unfocus();
    _activePanelList.removeLast();
    _controllerForgotPassword.reverse();
    _controllerSignIn.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: WillPopScope(
          child: Container(
            color: AppColors.primaryDark,
            child: SingleChildScrollView(
              physics: keyboardActive
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: _width * 0.15,
                      right: _width * 0.15,
                      left: _width * 0.15,
                      child: Image.asset(
                        'assets/images/stethoscope-icon-2316460_960_720.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
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
                                  _pushSignIn();
                                },
                                callSignUp: () {
                                  _pushSignUp();
                                },
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: this._controllerSignIn,
                        builder: (context, child) {
                          return Positioned(
                            bottom: 30,
                            left: 12,
                            right: 12,
                            child: Transform.translate(
                              offset: Offset(0, _animationSignIn.value),
                              child: SignInWidget(
                                onCloseCalled: () {
                                  _removeSignIn();
                                },
                                forgotPassword: () {
                                  _pushForgetPassword();
                                },
                              ),
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
                              child: SignUpWidget(
                                onCloseCalled: () {
                                  _removeSignUp();
                                },
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: this._controllerForgotPassword,
                        builder: (context, child) {
                          return Positioned(
                            bottom: 30,
                            left: 12,
                            right: 12,
                            child: Transform.translate(
                              offset: Offset(0, _animationForgotPassword.value),
                              child: ForgetPasswordWidget(
                                onCloseCalled: () {
                                  _removeForgetPassword();
                                },
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          onWillPop: () async {
            switch (_activePanelList[_activePanelList.length - 1]) {
              case _Panels.main:
                if (!doubleBackToExitState) {
                  // first back click
                  showOverlay(context);
                  doubleBackToExitState = true;
                  Future.delayed(Duration(seconds: secondsToExit)).then((_) {
                    if (mounted) {
                      doubleBackToExitState = false;
                    }
                  });
                  return false;
                }
                return true;
              case _Panels.signIn:
                _removeSignIn();
                return false;
              case _Panels.signUp:
                _removeSignUp();
                return false;
              case _Panels.forget:
                _removeForgetPassword();
                return false;
            }
            return true;
          }),
    );
  }

  void showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xE6FFFFFF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Press back again to exit",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: secondsToExit));
    overlayEntry.remove();
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
                  textColor: AppColors.brown,
                ),
                SizedBox(
                  height: 10,
                ),
                MyRoundedButton(
                  text: "Sign Up",
                  color: AppColors.secondaryAccent,
                  onTap: callSignUp,
                  textColor: AppColors.brown,
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

class SignInWidget extends StatefulWidget {
  final Function onCloseCalled;
  final Function forgotPassword;
  const SignInWidget({
    Key key,
    @required this.onCloseCalled,
    @required this.forgotPassword,
  }) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _autoValidate = false;

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
                    onTap: widget.onCloseCalled,
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
            SizedBox(height: 10),
            Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: AppColors.secondaryAccent,
                accentColor: AppColors.secondaryAccent,
                cursorColor: AppColors.secondaryAccent,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Email address",
                      ),
                      keyboardType: TextInputType.text,
                      validator: StringValidators.emailValidator,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: StringValidators.passwordValidator,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    MyRoundedButton(
                      text: "Forgot Password?",
                      onTap: widget.forgotPassword,
                      textColor: AppColors.whiteTextDull,
                      color: AppColors.primaryLight,
                    ),
                    SizedBox(height: 12),
                    MyRoundedButton(
                      text: "Continue",
                      color: AppColors.secondaryAccent,
                      textColor: AppColors.brown,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                        } else {
                          _autoValidate = true;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpWidget extends StatefulWidget {
  final Function onCloseCalled;

  const SignUpWidget({Key key, @required this.onCloseCalled}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _showPassword1 = false;
  bool _showPassword2 = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                    onTap: widget.onCloseCalled,
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
            SizedBox(height: 10),
            Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: AppColors.secondaryAccent,
                accentColor: AppColors.secondaryAccent,
                cursorColor: AppColors.secondaryAccent,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "First Name",
                      ),
                      keyboardType: TextInputType.text,
                      validator: StringValidators.nameValidator,
                      controller: _firstNameController,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Last Name",
                      ),
                      keyboardType: TextInputType.text,
                      validator: StringValidators.nameValidator,
                      controller: _lastNameController,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email address",
                      ),
                      keyboardType: TextInputType.text,
                      validator: StringValidators.emailValidator,
                      controller: _emailController,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword1 = !_showPassword1;
                            });
                          },
                          child: Icon(
                            _showPassword1 ? Icons.lock_open : Icons.lock,
                          ),
                        ),
                        labelText: "Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: !_showPassword1,
                      validator: StringValidators.passwordValidator,
                      controller: _passwordController,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword2 = !_showPassword2;
                            });
                          },
                          child: Icon(
                            _showPassword2 ? Icons.lock_open : Icons.lock,
                          ),
                        ),
                        labelText: "Confirm Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: !_showPassword2,
                      validator: StringValidators.passwordValidator,
                      controller: _confirmPasswordController,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 12),
                    MyRoundedButton(
                      text: "Create Account",
                      color: AppColors.secondaryAccent,
                      textColor: AppColors.brown,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                        } else {
                          _autoValidate = true;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordWidget extends StatefulWidget {
  final Function onCloseCalled;

  const ForgetPasswordWidget({
    Key key,
    @required this.onCloseCalled,
  }) : super(key: key);

  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _autoValidate = false;

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
                  "Reset Password",
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
                    onTap: widget.onCloseCalled,
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
            SizedBox(height: 10),
            Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: AppColors.secondaryAccent,
                accentColor: AppColors.secondaryAccent,
                cursorColor: AppColors.secondaryAccent,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Email address",
                      ),
                      keyboardType: TextInputType.text,
                      validator: StringValidators.emailValidator,
                      autovalidate: _autoValidate,
                    ),
                    SizedBox(height: 18),
                    MyRoundedButton(
                      text: "Confirm",
                      color: AppColors.secondaryAccent,
                      textColor: AppColors.brown,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                        } else {
                          _autoValidate = true;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
