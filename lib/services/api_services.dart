import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/mobile_verify_model.dart';
import 'package:doctor_on_call/utils/loder.dart';
import 'package:flutter/cupertino.dart';

import '../api/dio_client.dart';
import '../api/url.dart';
import '../models/get_categories_list_model.dart';

class ApiService {
  ApiClient apiClient = ApiClient();
  Dio dio = Dio();

  //----------------------------MOBILE VERIFY API-----------------------//
  Future<MobileVerifyModel?> mobileVerifyApi(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.mobileVerify,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        MobileVerifyModel responseData =
            MobileVerifyModel.fromJson(response.data);
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //----------------------------CATEGORIES LIST API-----------------------//
  Future<GetCategoriesListModel?> getCategoriesList() async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.categoriesList,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );
      if (response.statusCode == 200) {
        GetCategoriesListModel responseData =
            GetCategoriesListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }
}
