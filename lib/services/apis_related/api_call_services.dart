import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { GET, POST, PUT, DELETE }

Future<Map<String, dynamic>> authHeader() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get('token');
  return {'Authorization': 'Bearer ${((token)!)}'};
}

class ApiCall {
  final _dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    ),
  );

  static final ApiCall _apiServiceInstance = ApiCall();

  static ApiCall get instance => _apiServiceInstance;

  ApiCall() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    // Initialize the Dio logger

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: print, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
    _dio.options.validateStatus = (status) {
      return true;
    };
    _dio.interceptors.add(DioInterceptToCurl(printOnSuccess: true));
  }

  Future callApi({
    required String url,
    HttpMethod method = HttpMethod.GET,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
    bool dismissKeyBoard = true,
  }) async {
    try {
      if (dismissKeyBoard) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    } catch (e) {}
    try {
      Response response;

      switch (method) {
        case HttpMethod.GET:
          response = await _dio.get(
            url,
            options: Options(headers: headers),
            queryParameters: parameters,
          );
          break;
        case HttpMethod.POST:
          response = await _dio.post(
            url,
            options: Options(headers: headers),
            data: body,
            queryParameters: parameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(
            url,
            options: Options(headers: headers),
            data: body,
            queryParameters: parameters,
          );
          break;
        case HttpMethod.PUT:
          response = await _dio.put(
            url,
            options: Options(headers: headers),
            data: body,
            queryParameters: parameters,
          );
          break;
      }
      return _handleResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      } else if (ex.type == DioExceptionType.connectionError) {
        throw Exception("Connection Error Exception");
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    return response.data;
  }

  Future refreshToken() async {
    try {
      final response = await _dio.get('https://api.example.com/data');
      // Handle the successful response here
    } on DioException {
      // logger.e("Refresh Token Error: $ex");
      rethrow;
    } catch (e) {
      // logger.e("An error occurred during token refresh: $e");
      rethrow;
    }
  }
}

List<String> extractErrorMessages(Map<String, dynamic> response) {
  final List<String> errorMessages = [];
  try {
    if (response['data'] != null) {
      Map<String, dynamic> errors = response['data'];
      errors.forEach((key, value) {
        if (value is List) {
          errorMessages.addAll(value.cast<String>());
        }
      });
    }
  } catch (e) {}
  if (errorMessages.isEmpty) {
    errorMessages.add(response["message"]);
  }
  return errorMessages;
}
