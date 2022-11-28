import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_desgin_app/app/app_prefs.dart';
import 'package:mvvm_desgin_app/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String content_type = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authoriztion";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      content_type: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        headers: headers,
        receiveTimeout: Constant.apiTimeOut,
        sendTimeout: Constant.apiTimeOut);
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
