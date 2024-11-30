import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../dialogs/dialogs.dart';
import 'app_exceptions.dart';

class BaseClient01 {
  static const int TIME_OUT_DURATION = 60;

  //GET
  Future<dynamic> get(Uri api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    try {
      // DialogHelper.showLoading();
      var response = await http.get(api, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      print("response: ${response.body}");
      print("statusCode: ${response.statusCode}");
      DialogHelper.hideLoading();
      return _processResponse(response);
    } on SocketException {
      print("No Internet connection");
      // DialogHelper.snackbar("No Internet connection");
      // throw FetchDataException('No Internet connection', api.toString());
    } on TimeoutException {
      print("TimeoutException");
      // throw ApiNotRespondingException(
      //     'API not responded in time', api.toString());
    }
  }

  //POST
  Future<dynamic> post(Uri api, dynamic body) async {
    //check().then((intenet));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var userId = prefs.get('user_id');
    print("user_id : = $userId");
    print("token : = $token");

    print("body: " "$body");

    try {
      var response = await http.post(api, body: body, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      print("response status code: " "${response.statusCode}");
      print("response body: ${response.body}");
      return await _processResponse(response);
    } catch (e) {
      print("catch exception :  $e.toString() ");
      // DialogHelper.snackbar("$e ''");
    }
  }

  //DELETE

  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 404:
        var responseJson1 = jsonDecode(response.body);
        print("Wrong url  ${response.request!.url.toString()}");
        // DialogHelper.snackbar("Wrong Url");
        print(responseJson1);
        return responseJson1;
        break;
      case 400:
        print("Wrong url ${response.request!.url.toString()}");
        throw BadRequestException(jsonDecode(response.body), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        // DialogHelper.snackbar("Error occured with code");
        throw FetchDataException('Error occured with code : ${response.statusCode}', response.request!.url.toString());
    }
  }

  ///for notification
  ///
  ///
  ///

  Future<dynamic> sendNotification(String fcmToken, String screen, String title, String body) async {
    var headers = {
      'Authorization':
          'Bearer AAAAwJkN2Cg:APA91bG7soLszsdtnVHIJDMmd1ELciI3OSki8hgNYzBGtosOu-A6QdLMVoE_lPW5Xh_DXD0PI81FtzyZjne_s_0yg8RXyJgazY4nu8UuMZ6Cz2e5s5_AeACIsRZUli9kdXJm8-whw8j3',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "notification": {"title": title, "body": body},
      "data": {"screen": screen},
      "to": fcmToken
    });
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
