class FormValidators {
  static String? usernameValidator(String? val) {
    if (val!.isEmpty) {
      return 'Please fill in this field';
    }
    return null;
  }

  static String? emailValidator(String? val) {
    if (val!.isEmpty) {
      return 'Please fill in this field';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{1,}$').hasMatch(val)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? onlyNumber(String? val) {
    if (val!.isEmpty) {
      return 'Please fill in this field';
    } else if (!RegExp(r'^[0-9]$').hasMatch(val)) {
      return 'Please enter only number';
    }
    return null;
  }

  static String? passwordValidator(String? val) {
    if (val!.isEmpty) {
      return 'Please fill in this field';
    } else if (val.length < 8) {
      return 'Your password is less than 8 characters long';
    }
    return null;
  }

  static String? confirmPasswordValidator(
      String confirmPassword, String mainPassword) {
    if (confirmPassword.isEmpty) {
      return 'Please fill in this field';
    } else if (confirmPassword != mainPassword) {
      return 'The password does not match';
    }
    return null;
  }
}
