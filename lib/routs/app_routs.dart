
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:doctor_on_call/views/Auth/mobile_verification_screen.dart';
import 'package:doctor_on_call/views/Auth/otp_verification_screen.dart';
import 'package:doctor_on_call/views/Auth/reset_password_screen.dart';
import 'package:doctor_on_call/views/Auth/signup_screen.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/doctor_list_screen.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/specialist_doctor.dart';
import 'package:doctor_on_call/views/Dashbord/home_screen.dart';
import 'package:doctor_on_call/views/Dashbord/main_home_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_appointment_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_order_screen.dart';
import 'package:doctor_on_call/views/Dashbord/services_screen.dart';
import 'package:flutter/material.dart';

import '../views/Auth/forgot_password_screen.dart';
import '../views/splash/splash_screen.dart';

class Routs {
  static const String splash = "/splash_screen";
  static const String login = "/login_screen";
  static const String signUp = "/signup_screen";
  static const String forgotPassword = "/forgot_password_screen";
  static const String resetPassword = "/reset_password_screen";
  static const String otp = "/otp_verification_screen";
  static const String mobileVerification = "/mobile_verification_screen";
  static const String mainHome = "/main_home_screen";
  static const String home = "/home_screen";
  static const String myAppointment = "/my_appointment_screen";
  static const String myOrder = "/my_order_screen";
  static const String services = "/services_screen";
  static const String doctorList = "/doctor_list_screen";
  static const String specialistDoctor = "/specialist_doctor";


}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routs.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routs.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      case Routs.resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen());

      case Routs.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routs.otp:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen());

      case Routs.mainHome:
        return MaterialPageRoute(builder: (_) => MainHomeScreen());

      case Routs.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routs.myAppointment:
        return MaterialPageRoute(builder: (_) => const MyAppointmentScreen());

      case Routs.myOrder:
        return MaterialPageRoute(builder: (_) => const MyOrderScreen());

      case Routs.doctorList:
        return MaterialPageRoute(builder: (_) => const DoctorList());

      case Routs.services:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());

      case Routs.specialistDoctor:
        return MaterialPageRoute(builder: (_) => const SpecialistDoctor());

      case Routs.mobileVerification:
        return MaterialPageRoute(builder: (_) => MobileVerificationScreen());


      default:
        return null;
    }
  }
}