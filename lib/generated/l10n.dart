// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `AI changes \nlives — empowering \nthe future today.`
  String get slogan {
    return Intl.message(
      'AI changes \nlives — empowering \nthe future today.',
      name: 'slogan',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get emailHintText {
    return Intl.message(
      'email',
      name: 'emailHintText',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordHintText {
    return Intl.message(
      'password',
      name: 'passwordHintText',
      desc: '',
      args: [],
    );
  }

  /// `You don't have account?`
  String get youDontHaveAccount {
    return Intl.message(
      'You don`t have account?',
      name: 'youDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get nameHintText {
    return Intl.message(
      'name',
      name: 'nameHintText',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPasswordHintText {
    return Intl.message(
      'confirm password',
      name: 'confirmPasswordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Do you have an account already?`
  String get doYouHaveAnAccountAlready {
    return Intl.message(
      'Do you have an account already?',
      name: 'doYouHaveAnAccountAlready',
      desc: '',
      args: [],
    );
  }

  /// `How can i help you`
  String get howCanIHelpYouHintText {
    return Intl.message(
      'How can i help you',
      name: 'howCanIHelpYouHintText',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `The server is not available. Check your internet connection`
  String get theServerIsNotAvailableCheckYourInternetConnection {
    return Intl.message(
      'The server is not available. Check your internet connection',
      name: 'theServerIsNotAvailableCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in this field`
  String get pleaseFillInThisField {
    return Intl.message(
      'Please fill in this field',
      name: 'pleaseFillInThisField',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your password is less than 8 characters long`
  String get yourPasswordIsLessThan8CharactersLong {
    return Intl.message(
      'Your password is less than 8 characters long',
      name: 'yourPasswordIsLessThan8CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Please enter only number`
  String get pleaseEnterOnlyNumber {
    return Intl.message(
      'Please enter only number',
      name: 'pleaseEnterOnlyNumber',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match`
  String get thePasswordDoesNotMatch {
    return Intl.message(
      'The password does not match',
      name: 'thePasswordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password!`
  String get incorrectUsernameOrPassword {
    return Intl.message(
      'Incorrect username or password!',
      name: 'incorrectUsernameOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `There has been an error. Try again`
  String get thereHasBeenAnErrorTryAgain {
    return Intl.message(
      'There has been an error. Try again',
      name: 'thereHasBeenAnErrorTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmailFormat {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `No user found with this email`
  String get noUserFoundWithThisEmail {
    return Intl.message(
      'No user found with this email',
      name: 'noUserFoundWithThisEmail',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with different credentials`
  String get anAccountAlreadyExistsWithDifferentCredentials {
    return Intl.message(
      'An account already exists with different credentials',
      name: 'anAccountAlreadyExistsWithDifferentCredentials',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use`
  String get thisEmailIsAlreadyInUse {
    return Intl.message(
      'This email is already in use',
      name: 'thisEmailIsAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed`
  String get operationNotAllowed {
    return Intl.message(
      'Operation not allowed',
      name: 'operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 8 characters`
  String get passwordShouldBeAtLeast8Characters {
    return Intl.message(
      'Password should be at least 8 characters',
      name: 'passwordShouldBeAtLeast8Characters',
      desc: '',
      args: [],
    );
  }

  /// `The supplied auth credential is malformed or has expired`
  String get theSuppliedAuthCredentialIsMalformedOrHasExpired {
    return Intl.message(
      'The supplied auth credential is malformed or has expired',
      name: 'theSuppliedAuthCredentialIsMalformedOrHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Firebase error. Please try again`
  String get unknownFirebaseErrorPleaseTryAgain {
    return Intl.message(
      'Unknown Firebase error. Please try again',
      name: 'unknownFirebaseErrorPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about this?`
  String get areYouSureAboutThis {
    return Intl.message(
      'Are you sure about this?',
      name: 'areYouSureAboutThis',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out of your account?`
  String get areYouSureYouWantToLogOutOfYour {
    return Intl.message(
      'Are you sure you want to log out of your account?',
      name: 'areYouSureYouWantToLogOutOfYour',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get usedModel {
    return Intl.message(
      'Model',
      name: 'usedModel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
