import 'package:fluttertoast/fluttertoast.dart';

class ApiResponseModel<T> {
  bool? success;
  String message;
  T response;
  int statusCode;

  ApiResponseModel({
    this.success,
    required this.message,
    required this.response,
    required this.statusCode,
  });

  factory ApiResponseModel.fromJson(
      Map<String, dynamic> parsedData, int statusCode) {
    return ApiResponseModel(
      success: parsedData['success'],
      message: parsedData['message'] ?? '',
      response: parsedData['data'] ?? "",
      statusCode: statusCode,
    );
  }

  static errorShow(dynamic apiResponse) {
    if (apiResponse["error"] != null) {
      Fluttertoast.showToast(msg: apiResponse["error"]);
    } else if (apiResponse["message"] != null) {
      Fluttertoast.showToast(msg: apiResponse["message"]);
    } else if (apiResponse["msg"] != null) {
      Fluttertoast.showToast(msg: apiResponse["msg"]);
    } else if (apiResponse["errors"] != null) {
      Fluttertoast.showToast(msg: apiResponse["errors"].toString());
    } else if (apiResponse.reasonPhrase != null) {
      Fluttertoast.showToast(msg: apiResponse.reasonPhrase);
    }
  }
}
