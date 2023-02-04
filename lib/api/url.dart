import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://appointment.doctoroncalls.in";
  static const String get = "get_ajax";
  static const String post = "post_ajax";
  static const String mobileVerify = '$baseUrl/$get/mobile_verify';
  static const String categoriesList = '$baseUrl/$get/get_all_profile_type';
  static const String signUp = '$baseUrl/$post/add_account';
  static const String login = '$baseUrl/$get/login';
  static const String state = '$baseUrl/$get/get_states_for_android';
  static const String city = '$baseUrl/$get/get_district_for_android';
  static const String updateProfile = '$baseUrl/$post/update_kyc';
  static const String updatePassword = '$baseUrl/$post/update_pasword';
  static const String slider = '$baseUrl/$get/get_sliders';
  static const String privacyPolicy = '$baseUrl/$get/get_privacy_policy';
  static const String termsAndConditions = '$baseUrl/$get/get_terms_conditions';
}
