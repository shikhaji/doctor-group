import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/mobile_verify_model.dart';
import 'package:doctor_on_call/services/shared_referances.dart';
import 'package:doctor_on_call/utils/loder.dart';
import 'package:doctor_on_call/views/Dashbord/main_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/dio_client.dart';
import '../api/url.dart';
import '../models/common_model.dart';
import '../models/get_categories_list_model.dart';
import '../models/get_city_list_model.dart';
import '../models/get_state_list_model.dart';
import '../models/latest_news_model.dart';
import '../models/login_model.dart';
import '../models/slider_model.dart';
import '../models/privacy_policy_model.dart';
import '../routs/app_routs.dart';
import '../routs/arguments.dart';
import '../views/Auth/login_screen.dart';

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

  //-----------------------------STATE LIST API---------------------------//
  Future<GetStateListModel?> getStateList() async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.state,
        options: Options(headers: {"Content-Type": 'application/json'}),
      );
      if (response.statusCode == 200) {
        GetStateListModel responseData =
            GetStateListModel.fromJson(response.data);
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

//-----------------------------CITY LIST API---------------------------//
  Future<GetCityListModel?> getCityList(String stateId) async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"stateid": stateId});
      response = await dio.post(EndPoints.city,
          options: Options(headers: {"Content-Type": 'application/json'}),
          data: formData);
      if (response.statusCode == 200) {
        GetCityListModel responseData =
            GetCityListModel.fromJson(response.data);
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

  //----------------------------SIGNUP API-----------------------//
  Future signUp(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.signUp,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Sign Up Successfully...',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamed(context, Routs.login);

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
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

  //----------------------------LOGIN API-----------------------//
  Future<LoginModel?> login(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.login,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusMessage == "OK") {
        LoginModel responseData = LoginModel.fromJson(response.data);
        Preferances.setString("userId", responseData.id);
        Preferances.setString("Token", responseData.loginToken);
        Preferances.setString("userType", responseData.businessType);
        Loader.hideLoader();

        Fluttertoast.showToast(
          msg: 'login Successfully...',
          backgroundColor: Colors.grey,
        );
        if (responseData.profileStatus == 0) {
          Navigator.pushNamed(context, Routs.updateProfile,
              arguments: OtpArguments(userId: responseData.id));
        } else {
          Navigator.pushNamed(context, Routs.mainHome);
        }

        return responseData;
      } else {
        Fluttertoast.showToast(
          msg: 'Invalid Login Credential',
          backgroundColor: Colors.grey,
        );
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

  //----------------------------UPDATE PROFILE API--------------//
  Future updateProfile(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      String? id = await Preferances.getString("userId");
      String? token = await Preferances.getString("userToken");
      String? type = await Preferances.getString("userType");
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.updateProfile,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
            "User-ID": id,
            "Authorization": token,
            "type": type,
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Your Profile Updated Successfully...',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamed(context, Routs.mainHome);

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
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

  //----------------------------UPDATE PASSWORD API-----------------------//
  Future updatePassword(
    BuildContext context, {
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.updatePassword,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Password Updated...!',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamed(context, Routs.login);

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Fluttertoast.showToast(
          msg: 'Something Went Wrong',
          backgroundColor: Colors.grey,
        );
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------SLIDER API-----------------------//
  Future<SliderModel> slider(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.slider,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        SliderModel responseData = SliderModel.fromJson(response.data);
        Loader.hideLoader();
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

  //-----------------------LATEST NEWS API-----------------------//
  Future<LatestNewsModel> latestNews(BuildContext context) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.latestNews,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );

      if (response.statusCode == 200) {
        LatestNewsModel responseData = LatestNewsModel.fromJson(response.data);
        Loader.hideLoader();
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

  //----------------------------Privacy Policy-----------------------//
  Future<PrivacyPolicyModel?> privacyPolicy(BuildContext context) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.privacyPolicy);
      if (response.statusCode == 200) {
        PrivacyPolicyModel responseData =
            PrivacyPolicyModel.fromJson(response.data);
        Loader.hideLoader();

        debugPrint('responseData ----- > $responseData');
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
}
