import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/all_main_category_model.dart';
import 'package:doctor_on_call/models/get_transation_model.dart';
import 'package:doctor_on_call/models/get_wallet_model.dart';
import 'package:doctor_on_call/models/mobile_verify_model.dart';
import 'package:doctor_on_call/services/shared_referances.dart';
import 'package:doctor_on_call/utils/loder.dart';
import 'package:doctor_on_call/views/Dashbord/main_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../api/dio_client.dart';
import '../api/url.dart';
import '../models/about_us_model.dart';
import '../models/common_model.dart';
import '../models/get_all_profile_model.dart';
import '../models/get_all_service_model.dart';
import '../models/get_categories_list_model.dart';
import '../models/get_city_list_model.dart';
import '../models/get_days_model.dart';
import '../models/get_profile_model.dart';
import '../models/get_state_list_model.dart';
import '../models/get_sub_categories_model.dart';
import '../models/get_time_slot_by_doctor_model.dart';
import '../models/get_time_slot_model.dart';
import '../models/latest_news_model.dart';
import '../models/login_model.dart';
import '../models/slider_model.dart';
import '../models/privacy_policy_model.dart';
import '../models/terms_and_condition_model.dart';
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
      CommonModel commonModel = CommonModel.fromJson(response.data);
      if (commonModel.status == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: '${commonModel.message}',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamed(context, Routs.login);
        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: '${commonModel.message}',
          backgroundColor: Colors.grey,
        );
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
    String? phoneNumber,
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
      LoginModel responseData = LoginModel.fromJson(response.data);
      if (responseData.message == "ok") {
        print("responseData.profileStatus:=${responseData.profileStatus}");
        Preferances.setString("userId", responseData.id);
        Preferances.setString("Token", responseData.loginToken);
        Preferances.setString("userType", responseData.businessType);
        Preferances.setString("profileStatus", responseData.profileStatus);
        String businessType = await Preferances.prefGetString("userType", '');

        print("profile store get Status:=${businessType}");
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'login Successfully...',
          backgroundColor: Colors.grey,
        );
        if (responseData.profileStatus == "0") {
          print("phoneNumber is here:=${phoneNumber}");
          Navigator.pushNamed(
            context,
            Routs.updateProfile,
            arguments: SendArguments(
                userId: responseData.id,
                phoneNumber: phoneNumber,
                ptId: responseData.businessType),
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Routs.mainHome, (route) => false,
              arguments: SendArguments(bottomIndex: 0));
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

        Navigator.pushNamed(context, Routs.myLocation);
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

  //----------------------------PRIVACY POLICY API-----------------------//
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

  //----------------------------TERMS AND CONDITION API-----------------------//
  Future<TermsAndConditionModel?> termsAndCondition(
      BuildContext context) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.termsAndConditions);
      if (response.statusCode == 200) {
        TermsAndConditionModel responseData =
            TermsAndConditionModel.fromJson(response.data);
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

  //----------------------------ABOUT US API-----------------------//
  Future<AboutUsModel?> aboutUs(BuildContext context) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.aboutUs);
      if (response.statusCode == 200) {
        AboutUsModel responseData = AboutUsModel.fromJson(response.data);
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

  //----------------------------ALL SERVICES LIST API-----------------------//
  Future<GetAllServicesModel?> getServicesList() async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.allService,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );
      if (response.statusCode == 200) {
        GetAllServicesModel responseData =
            GetAllServicesModel.fromJson(response.data);
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

  //----------------------------SUB CATEGORIES LIST API-----------------------//
  Future<GetSubCategoryModel?> getSubCategoriesList(String ptid) async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"ptid": ptid});
      response = await dio.post(EndPoints.allMainCategory,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: formData);
      if (response.statusCode == 200) {
        GetSubCategoryModel responseData =
            GetSubCategoryModel.fromJson(response.data);
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

  //----------------------------SUB CATEGORIES LIST API-----------------------//
  Future<GetAllProfileModel?> getAllProfileList(
      String ptId, String catId) async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData =
          FormData.fromMap({"catid": catId, "profile_type": ptId});
      response = await dio.post(EndPoints.getAllProfileList,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: formData);
      if (response.statusCode == 200) {
        GetAllProfileModel responseData =
            GetAllProfileModel.fromJson(response.data);
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

  //----------------------------TIME SLOT LIST API-----------------------//
  Future<GetTimeSlotModel?> getTimeSlotList() async {
    try {
      Loader.showLoader();
      Response response;

      response = await dio.post(
        EndPoints.getTimeSlot,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );
      if (response.statusCode == 200) {
        GetTimeSlotModel responseData =
            GetTimeSlotModel.fromJson(response.data);

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

  //----------------------------DAYS LIST API-----------------------//
  Future<GetDaysModel?> getDaysList() async {
    try {
      Loader.showLoader();
      Response response;

      response = await dio.post(
        EndPoints.getDays,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );
      if (response.statusCode == 200) {
        GetDaysModel responseData = GetDaysModel.fromJson(response.data);

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

//----------------------------ADD DOCTOR MEETING SCHEDULE  API-----------------------//
  Future addDoctorMeetingSchedule(BuildContext context,
      {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.addDoctorMeetingSchedule,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        Loader.hideLoader();
        debugPrint('meeting add data responseData ----- > ${response.data}');
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.mainHome, (route) => false,
            arguments: SendArguments(bottomIndex: 0));
        Fluttertoast.showToast(
          msg: 'Meeting schedule Successfully !',
          backgroundColor: Colors.grey,
        );
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

  //---------------------------- GET WALLET BALANCE API-----------------------//
  Future<GetWalletModel?> getWalletBalance() async {
    try {
      String? id = await Preferances.getString("userId");
      FormData formData = FormData.fromMap({
        "loginid": id!.replaceAll('"', '').replaceAll('"', '').toString(),
      });
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getCurrentBalance,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: formData);
      if (response.statusCode == 200) {
        GetWalletModel responseData = GetWalletModel.fromJson(response.data);
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

  //---------------------------- ADD WALLET BALANCE API-----------------------//
  Future addWallet(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.addWallet,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Wallet Balance amount added !',
          backgroundColor: Colors.grey,
        );
        Loader.hideLoader();
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

  //---------------------------- GET TRANSACTION HISTORY API-----------------------//
  Future<GetTransactionModel?> getTransactionHistoryApi() async {
    try {
      String? id = await Preferances.getString("userId");
      FormData formData = FormData.fromMap({
        "loginid": id!.replaceAll('"', '').replaceAll('"', '').toString(),
      });
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.transactionHistory,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: formData);
      if (response.statusCode == 200) {
        GetTransactionModel responseData =
            GetTransactionModel.fromJson(response.data);
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

  //----------------------------GET TIME SLOT BY DOCTOR LIST API-----------------------//
  Future<GetTimeSlotByDoctorModel?> getTimeSlotByDoctor(BuildContext context,
      {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.getTimeSlotByDoctor,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
        data: data,
      );
      if (response.statusCode == 200) {
        GetTimeSlotByDoctorModel responseData =
            GetTimeSlotByDoctorModel.fromJson(response.data);

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

  //----------------------------ADD DOCTOR BOOKING API-----------------------//
  Future<void> addDoctorBooking(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.addDoctorBooking,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Booking add Successfully!',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.mainHome, (route) => false,
            arguments: SendArguments(bottomIndex: 2));
        Loader.hideLoader();
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

  //----------------------------UPLOAD PRESCRIPTION BY PATIENT API-----------------------//
  Future<void> uploadPrescriptionByPatient(BuildContext context,
      {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.uploadPrescriptionByPatient,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Booking add Successfully!',
          backgroundColor: Colors.grey,
        );
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.mainHome, (route) => false,
            arguments: SendArguments(bottomIndex: 0));
        Loader.hideLoader();
      } else {
        Loader.hideLoader();
        throw Exception(response);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }

  //-----------------------------GET PROFILE DATA API---------------------------//
  Future<GetProfileDataModel?> getProfileData() async {
    try {
      Loader.showLoader();
      Response response;
      String? id = await Preferances.getString("userId");
      FormData formData = FormData.fromMap({
        "loginid": id!.replaceAll('"', '').replaceAll('"', '').toString(),
      });
      response = await dio.post(EndPoints.getProfile,
          // options: Options(headers: {"Content-Type": 'application/json'}),
          data: formData);
      if (response.statusCode == 200) {
        GetProfileDataModel responseData =
            GetProfileDataModel.fromJson(response.data);
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

  //----------------------------ADD DOCTOR BOOKING API-----------------------//
  Future<void> updateMyProfile(BuildContext context, {Map? data}) async {
    try {
      Loader.showLoader();
      // var url =
      //     "https://appointment.doctoroncalls.in/post_ajax/update_business_profile";
      // var response = await http.post(Uri.parse(url), body: data, headers: {
      //   "Client-Service": "frontend-client",
      //   "Auth-Key": 'simplerestapi',
      // });
      Response response;
      response = await dio.post(EndPoints.updateMyProfile,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Profile update Successfully!',
          backgroundColor: Colors.grey,
        );
        Loader.hideLoader();
      } else {
        Loader.hideLoader();
        throw Exception(response);
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
