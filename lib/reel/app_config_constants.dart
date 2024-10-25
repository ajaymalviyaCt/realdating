//import '../screens/settings_menu/settings_controller.dart';
import 'color_extension.dart';
import 'constant_util.dart';
import 'package:realdating/reel/common_import.dart';

//final SettingsController settingsController = Get.find();

class AppConfigConstants {
  // Name of app
  static String appName = 'App_name';

  static String currentVersion = '2.2';
  static const liveAppLink = 'https://www.google.com/';

  static String appTagline = 'Share your day activity with friends';
  static const googleMapApiKey = 'add your google map api key';

  // static const restApiBaseUrl = 'https://product.fwdtechnology.co/socialified/api/web/v1/';
  static const restApiBaseUrl = 'https://forreal.net:4000/';

  // Socket api url
  static const socketApiBaseUrl = "your_socket_api_url";

  // Chat encryption key -- DO NOT CHANGE THIS
  static const encryptionKey = 'bbC2H19lkVbQDfakxcrtNMQdd0FloLyw';

  // enable encryption -- DO NOT CHANGE THIS
  static const int enableEncryption = 1;

  // chat version
  static const int chatVersion = 1;

  // is demo app
  static const bool isDemoApp = true;

  // parameters for delete chat
  static const secondsInADay = 86400;
  static const secondsInThreeDays = 259200;
  static const secondsInSevenDays = 604800;
}

class DesignConstants {
  static double horizontalPadding = 24;
}

class AppColorConstants {
  static Color themeColor =  Colors.blue ;

  static Color get backgroundColor => isDarkMode
      ? HexColor.fromHex(
          '202020')
      : HexColor.fromHex(
           'FFFFFF');

  static Color get cardColor => isDarkMode
      ? HexColor.fromHex(
               '202020')
          .lighten(0.05)
      : HexColor.fromHex(

                  'FFFFFF')
          .darken(0.05);

  static Color get dividerColor => isDarkMode
      ? const Color(0xFFFFFFFF).withOpacity(0.4)
      : Colors.grey.withOpacity(0.7);

  static Color get borderColor =>
      isDarkMode ? Colors.white.withOpacity(0.9) : Colors.grey.withOpacity(0.2);

  static Color get disabledColor =>
      isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.2);

  static Color get shadowColor => isDarkMode
      ? Colors.white.withOpacity(0.2)
      : Colors.black.withOpacity(0.2);

  static Color get iconColor =>
      isDarkMode ? Colors.white : const Color(0xFF212121);

  static Color get inputFieldTextColor =>
      isDarkMode ? const Color(0xFFFAFAFA) : const Color(0xFF212121);

  static Color get inputFieldPlaceholderTextColor => isDarkMode
      ? const Color(0xFFFAFAFA).lighten()
      : const Color(0xFF212121).darken();

  static Color get red => isDarkMode ? Colors.red : Colors.red;

  static Color get green => isDarkMode ? Colors.green : Colors.green;

  // text colors

  static Color get mainTextColor => isDarkMode
      ?  Colors.white
      : Colors.black;

  static Color get subHeadingTextColor => isDarkMode
      ? const Color(0xFF34495e)
      : const Color(0xFF34495e);
}

class DatingProfileConstants {
  static List<String> genders = ['Male', 'Female', 'Other'];
  static List<String> colors = ['Black', 'White', 'Brown'];
  static List<String> religions = [
    'Christians',
    'Muslims',
    'Hindus',
    'Buddhists',
    'Sikhs',
    'Jainism',
    'Judaism'
  ];
  static List<String> maritalStatus = ['Single', 'Married', 'Divorced'];
  static List<String> drinkHabits = ['Regular', 'Planning to quit', 'Socially'];
}
