import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mvvm_desgin_app/app/constants.dart';
import 'package:mvvm_desgin_app/data/network/faliure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Faliuer faliuer;
  ErrorHandler.handel(dynamic error) {
    if (error is DioError) {
      faliuer = _handlerError(error);
    } else {
      faliuer = DataSource.DEFAULT.getFaliuer();
    }
  }
}

Faliuer _handlerError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFaliuer();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFaliuer();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFaliuer();
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFaliuer();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFaliuer();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Faliuer(
            code: error.response?.statusCode ?? Constant.zero,
            message: error.response?.statusMessage ?? Constant.empty);
      } else {
        return DataSource.DEFAULT.getFaliuer();
      }
  }
}

extension DataSourceExtension on DataSource {
  Faliuer getFaliuer() {
    switch (this) {
      case DataSource.NO_INTERNET_CONNECTION:
        return Faliuer(
            code: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.CACHE_ERROR:
        return Faliuer(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSource.SEND_TIMEOUT:
        return Faliuer(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSource.RECIEVE_TIMEOUT:
        return Faliuer(
            code: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.CANCEL:
        return Faliuer(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSource.CONNECT_TIMEOUT:
        return Faliuer(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Faliuer(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.NOT_FOUND:
        return Faliuer(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);
      case DataSource.UNAUTORISED:
        return Faliuer(
            code: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case DataSource.FORBIDDEN:
        return Faliuer(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);
      case DataSource.NO_CONTENT:
        return Faliuer(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);
      case DataSource.SUCCESS:
        return Faliuer(
            code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);
      case DataSource.DEFAULT:
        return Faliuer(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; //success with no data (no content)
  static const int BAD_REQUEST = 400; //failure, API reject request
  static const int UNAUTORISED = 401; //failure ,user is not authorised
  static const int NOT_FOUND = 404; ////failure, API reject request
  static const int FORBIDDEN = 403; ////failure, API reject request
  static const int INTERNAL_SERVER_ERROR = 500; //failure , crash in server side

//local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; //success with data
  static const String NO_CONTENT =
      "success"; //success with no data (no content)
  static const String BAD_REQUEST = "Bad request, Try again later";
  static const String FORBIDDEN =
      "Bad request, Try again later"; //failure, API reject request
  static const String UNAUTORISED =
      "User is unauthorised, try agin later"; //failure ,user is not authorised
  static const String NOT_FOUND =
      "Forbidden request, try again later"; ////failure, API reject request
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went worng, try again later"; //failure , crash in server side

//local status code
  static const String CONNECT_TIMEOUT = "Time out error, try again latr";
  static const String CANCEL = "Request was cancelled, try again later";
  static const String RECIEVE_TIMEOUT = "Time out error, try agai later";
  static const String SEND_TIMEOUT = "Time out error, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String DEFAULT = "Some thing went wrong ,please try again later";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FALIUER = 1;
}
