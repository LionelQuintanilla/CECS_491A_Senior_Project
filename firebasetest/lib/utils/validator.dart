class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.length < 8) {
      return '🚩 Password must be at least 8 characters';
    } else {
      return null;
    }
  }

  static String? fullNameValidate(String fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName.isEmpty) {
      return 'Please enter full name';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid full name';
    }
    return null;
  }
}