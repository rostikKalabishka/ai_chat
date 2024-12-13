import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  final SharedPreferences sharedPref;

  Helpers({
    required SharedPreferences mySharedPref,
  }) : sharedPref = mySharedPref;

  Future<bool> showOnboarding() async {
    bool showOnboarding = (sharedPref.getBool('showOnboarding') ?? true);

    return showOnboarding;
  }

  Future<void> setBoolForShowOnboarding(
      {required bool showOnboardingBool}) async {
    await sharedPref.setBool('showOnboarding', showOnboardingBool);
  }
}
