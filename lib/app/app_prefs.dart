import 'package:mvvm_desgin_app/presentation/resource/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_IS_USER_SEE_ONBOARDING_VIEW =
    "PREFS_KEY_IS_USER_SEE_ONBOARDING_VIEW";
const String PREFS_KEY_IS_USER_LOGAIN_IN = "PREFS_KEY_IS_USER_LOGAIN_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

//onBoarding
  Future<void> setOnBoardingViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_SEE_ONBOARDING_VIEW, true);
  }

  Future<bool> isOnBoardingViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_SEE_ONBOARDING_VIEW) ??
        false;
  }
  //login
  Future<void> setUserLogin() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGAIN_IN, true);
  }

  Future<bool> isUerLogin() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGAIN_IN) ??
        false;
  }
}
