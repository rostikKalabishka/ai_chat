import 'package:ai_chat/generated/l10n.dart';
import 'package:flutter/material.dart';

class FormValidators {
  static String? usernameValidator(String? val, BuildContext context) {
    if (val!.isEmpty) {
      return S.of(context).pleaseFillInThisField;
    }
    return null;
  }

  static String? emailValidator(String? val, BuildContext context) {
    if (val!.isEmpty) {
      return S.of(context).pleaseFillInThisField;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{1,}$').hasMatch(val)) {
      return S.of(context).pleaseEnterAValidEmail;
    }
    return null;
  }

  static String? onlyNumber(String? val, BuildContext context) {
    if (val!.isEmpty) {
      return S.of(context).pleaseFillInThisField;
    } else if (!RegExp(r'^[0-9]$').hasMatch(val)) {
      return S.of(context).pleaseEnterOnlyNumber;
    }
    return null;
  }

  static String? passwordValidator(String? val, BuildContext context) {
    if (val!.isEmpty) {
      return S.of(context).pleaseFillInThisField;
    } else if (val.length < 8) {
      return S.of(context).yourPasswordIsLessThan8CharactersLong;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      String confirmPassword, String mainPassword, BuildContext context) {
    if (confirmPassword.isEmpty) {
      return S.of(context).pleaseFillInThisField;
    } else if (confirmPassword != mainPassword) {
      return S.of(context).thePasswordDoesNotMatch;
    }
    return null;
  }
}
