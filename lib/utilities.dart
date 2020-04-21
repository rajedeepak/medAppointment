class StringValidators {
  static String emailValidator(text) {
    print('Email validator');
    if (text.isEmpty) {
      return "Please enter an email";
    }
    RegExp exp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if (!exp.hasMatch(text)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String passwordValidator(text) {
    print('Password validator');
    if (text.isEmpty) {
      return "Please enter a password";
    }
    RegExp exp = new RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])(?!.*\s).{8,30}$");

    if (!exp.hasMatch(text)) {
      return "Please enter a valid password";
    }
    return null;
  }

  static String nameValidator(text) {
    print('Name validator');
    if (text.isEmpty) {
      return "Please enter some text";
    }
    RegExp exp = new RegExp(r"^[a-zA-Z\s]{1,}$");
    if (!exp.hasMatch(text)) {
      return "Please enter a valid name";
    }
    return null;
  }

  static String numberValidator(text) {
    print('Number validator');
    if (text.isEmpty) {
      return "Enter a phone number";
    }
    RegExp exp = new RegExp(r"^[0-9()+-]{9,}$");
    if (!exp.hasMatch(text)) {
      return "Please enter a valid number";
    }
    return null;
  }

  static String otpValidator(text) {
    print('otp validator');
    if (text.isEmpty) {
      return "Please enter the OTP";
    }
    RegExp exp = new RegExp(r"^[0-9A-Z]{6}$");
    if (!exp.hasMatch(text)) {
      return "Please enter a valid OTP";
    }
    return null;
  }
}
