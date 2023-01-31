import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/api/url.dart';

import '../models/api_response_model.dart';
import '../utils/function.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  ));

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    bool internetStatus = await CommonFunctions.checkConnectivity();

    if (internetStatus) {
      try {
        final Response response = await dio.post(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        ApiResponseModel responseData =
            await apiResponseModel(response.data, response.statusCode);

        return responseData;
      } on SocketException {
        throw NoInternetException(
            "Something went wrong with server connection, please check after some time");
      } on DioError catch (e) {
        throw e.error;
      }
    } else {
      return apiResponseModel({'message': '', 'status': 0, 'data': ''}, 1001);
    }
  }

  Future<ApiResponseModel> apiResponseModel(
      dynamic response, statusCode) async {
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response, statusCode);
    return apiResponseModel;
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([
    this._prefix,
    this._message,
  ]);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class NoInternetException extends AppException {
  NoInternetException([String message = '']) : super("", message);
}

class FetchDataException extends AppException {
  FetchDataException([String message = ''])
      : super("Error During Communication!, ", message);
}

class BadRequestException extends AppException {
  BadRequestException([String message = '']) : super("", message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String message = '']) : super("", message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message = '']) : super("", message);
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = '';

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
