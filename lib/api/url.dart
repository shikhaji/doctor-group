import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://appointment.doctoroncalls.in";
  static const String get = "get_ajax";
  static const String post = "post_ajax";
  static const String mobileVerify = '$baseUrl/$get/mobile_verify';
  static const String categoriesList = '$baseUrl/$get/get_all_profile_type';
  static const String signUp = '$baseUrl/$post/add_account';
  static const String login = '$baseUrl/$get/login';
  static const String state = '$baseUrl/$get/get_states';
  static const String city = '$baseUrl/$get/get_district';
  static const String slider = '$baseUrl/$get/get_sliders';
}
