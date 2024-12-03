import 'package:local_auth/local_auth.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:realdating/zzzzzz/constant_util.dart';
import 'package:realdating/zzzzzz/helper/color_extension.dart';
import 'package:realdating/zzzzzz/setting_model.dart';
import 'package:realdating/zzzzzz/utis/shared_prefs.dart';

final SettingsController settingsController = Get.find();

class SettingsController extends GetxController {
  Rx<SettingModel?> setting = Rx<SettingModel?>(null);
  RxString currentLanguage = 'en'.obs;

  RxBool bioMetricAuthStatus = false.obs;
  RxBool darkMode = false.obs;
  RxBool shareLocation = false.obs;

  RxInt redeemCoins = 0.obs;
  RxBool forceUpdate = false.obs;
  RxBool? appearanceChanged = false.obs;

  var localAuth = LocalAuthentication();
  RxInt bioMetricType = 0.obs;
  RxBool isPrivateAccount = false.obs;
  RxBool isShareOnlineStatus = true.obs;

  List<Map<String, String>> languagesList = [
    {'language_code': 'hi', 'language_name': 'Hindi'},
    {'language_code': 'en', 'language_name': 'English'},
    {'language_code': 'ar', 'language_name': 'Arabic'},
    {'language_code': 'tr', 'language_name': 'Turkish'},
    {'language_code': 'ru', 'language_name': 'Russian'},
    {'language_code': 'es', 'language_name': 'Spanish'},
    {'language_code': 'fr', 'language_name': 'French'},
    {'language_code': 'pt', 'language_name': 'Brazil'},
  ];

  setCurrentSelectedLanguage() async {
    String currentLanguage = await SharedPrefs().getLanguage();
    changeLanguage({'language_code': currentLanguage});
  }

  changeLanguage(Map<String, String> language) async {
    var locale = Locale(language['language_code']!);
    Get.updateLocale(locale);
    currentLanguage.value = language['language_code']!;
    update();
    SharedPrefs().setLanguage(language['language_code']!);
  }

  redeemCoinValueChange(int coins) {
    redeemCoins.value = coins;
  }

  loadSettings() async {
    bool isDarkTheme = await SharedPrefs().isDarkMode();
    bioMetricAuthStatus.value = await SharedPrefs().getBioMetricAuthStatus();
    // shareLocation.value = _userProfileManager.user.value!.latitude != null;
    // isPrivateAccount.value = _userProfileManager.user.value!.isPrivate;
    // isShareOnlineStatus.value = _userProfileManager.user.value!.isShareOnlineStatus;
    setDarkMode(isDarkTheme);
    checkBiometric();
  }

  setDarkMode(bool status) async {
    darkMode.value = status;
    darkMode.refresh();
    isDarkMode = status;
    await SharedPrefs().setDarkMode(status);
    Get.changeThemeMode(status ? ThemeMode.dark : ThemeMode.light);
  }

  appearanceModeChanged(bool status) async {
    await setDarkMode(status);
    appearanceChanged?.value = !appearanceChanged!.value;
  }

  Future checkBiometric() async {
    bool bioMetricAuthStatus = true; //await SharedPrefs().getBioMetricAuthStatus();
    if (bioMetricAuthStatus == true) {
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        // Face ID.
        bioMetricType.value = 1;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
        bioMetricType.value = 2;
      }
    }
    return;
  }
}

class DesignConstants {
  static double horizontalPadding = 24;
}

class AppColorConstants {
  static Color themeColor = settingsController.setting.value == null ? Colors.blue : HexColor.fromHex(settingsController.setting.value!.themeColor!);

  static Color get backgroundColor => isDarkMode
      ? HexColor.fromHex(settingsController.setting.value?.bgColorForDarkTheme ?? '202020')
      : HexColor.fromHex(settingsController.setting.value?.bgColorForLightTheme ?? 'FFFFFF');

  static Color get cardColor => isDarkMode
      ? HexColor.fromHex(settingsController.setting.value?.bgColorForDarkTheme ?? '202020').lighten(0.05)
      : HexColor.fromHex(settingsController.setting.value?.bgColorForLightTheme ?? 'FFFFFF').darken(0.05);

  static Color get dividerColor => isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.4) : Colors.grey.withOpacity(0.7);

  static Color get borderColor => isDarkMode ? Colors.white.withOpacity(0.9) : Colors.grey.withOpacity(0.2);

  static Color get disabledColor => isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.2);

  static Color get shadowColor => isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);

  // static Color get inputFieldBackgroundColor =>
  //     isDarkMode ? const Color(0xFF212121) : const Color(0xFF212121);

  static Color get iconColor => isDarkMode ? Colors.white : const Color(0xFF212121);

  static Color get inputFieldTextColor => isDarkMode ? const Color(0xFFFAFAFA) : const Color(0xFF212121);

  static Color get inputFieldPlaceholderTextColor => isDarkMode ? const Color(0xFFFAFAFA).lighten() : const Color(0xFF212121).darken();

  static Color get red => isDarkMode ? Colors.red : Colors.red;

  static Color get green => isDarkMode ? Colors.green : Colors.green;

  // text colors

  static Color get mainTextColor => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white
          : HexColor.fromHex(settingsController.setting.value!.textColorForDarkTheme!)
      : settingsController.setting.value == null
          ? Colors.black
          : HexColor.fromHex(settingsController.setting.value!.textColorForLightTheme!);

  static Color get subHeadingTextColor => isDarkMode
      ? settingsController.setting.value == null
          ? const Color(0xFF34495e)
          : HexColor.fromHex(settingsController.setting.value!.textColorForDarkTheme!).withOpacity(0.8)
      : settingsController.setting.value == null
          ? const Color(0xFFecf0f1)
          : HexColor.fromHex(settingsController.setting.value!.textColorForLightTheme!).withOpacity(0.8);

// static Color get subHeadingTextColor => isDarkMode
//     ? settingsController.setting.value == null
//         ? Colors.white.withOpacity(0.5)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForDarkTheme!)
//             .withOpacity(0.5)
//     : settingsController.setting.value == null
//         ? Colors.black.withOpacity(0.5)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForLightTheme!)
//             .withOpacity(0.5);
//
// static Color get subHeadingTextColor => isDarkMode
//     ? settingsController.setting.value == null
//         ? Colors.white.withOpacity(0.4)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForDarkTheme!)
//             .withOpacity(0.4)
//     : settingsController.setting.value == null
//         ? Colors.black.withOpacity(0.4)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForLightTheme!)
//             .withOpacity(0.4);

// static Color get subHeadingTextColor => isDarkMode
//     ? settingsController.setting.value == null
//         ? Colors.white.withOpacity(0.3)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForDarkTheme!)
//             .withOpacity(0.3)
//     : settingsController.setting.value == null
//         ? Colors.black.withOpacity(0.3)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForLightTheme!)
//             .withOpacity(0.3);
//
// static Color get subHeadingTextColor => isDarkMode
//     ? settingsController.setting.value == null
//         ? Colors.white.withOpacity(0.2)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForDarkTheme!)
//             .withOpacity(0.2)
//     : settingsController.setting.value == null
//         ? Colors.black.withOpacity(0.2)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForLightTheme!)
//             .withOpacity(0.2);
//
// static Color get subHeadingTextColor => isDarkMode
//     ? settingsController.setting.value == null
//         ? Colors.white.withOpacity(0.1)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForDarkTheme!)
//             .withOpacity(0.1)
//     : settingsController.setting.value == null
//         ? Colors.black.withOpacity(0.1)
//         : HexColor.fromHex(
//                 settingsController.setting.value!.textColorForLightTheme!)
//             .withOpacity(0.1);
}
