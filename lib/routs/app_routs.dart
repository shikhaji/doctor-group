import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:doctor_on_call/views/Auth/mobile_verification_screen.dart';
import 'package:doctor_on_call/views/Auth/otp_verification_screen.dart';
import 'package:doctor_on_call/views/Auth/reset_password_screen.dart';
import 'package:doctor_on_call/views/Auth/signup_screen.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/pathology_and_chemist_form_screen.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/book_appointment_screen.dart';

import 'package:doctor_on_call/views/Dashbord/doctor_services/doctor_profile__list_screen.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/sub_category_doctor.dart';
import 'package:doctor_on_call/views/Dashbord/home_screen.dart';
import 'package:doctor_on_call/views/Dashbord/main_home_screen.dart';
import 'package:doctor_on_call/views/Dashbord/meeting_schedule_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_appointment_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_order_screen.dart';
import 'package:doctor_on_call/views/Dashbord/services_screen.dart';
import 'package:doctor_on_call/views/Dashbord/wallet/wallet_screen.dart';
import 'package:doctor_on_call/views/Side%20menu/about_us.dart';
import 'package:doctor_on_call/views/Side%20menu/privacy_policy.dart';
import 'package:doctor_on_call/views/Side%20menu/terms_and_condition_screen.dart';
import 'package:flutter/material.dart';

import '../views/Auth/forgot_password_screen.dart';
import '../views/Auth/update_profile_screen.dart';
import '../views/Dashbord/wallet/transation_history_screen.dart';
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
  static const String updateProfile = "/update_profile_screen";
  static const String meetingSchedule = "/meeting_schedule";
  static const String privacyPolicy = "/privacy_policy";
  static const String termsAndCondition = "/terms_and_condition_screen";
  static const String aboutUs = "/about_us";
  static const String wallet = "/wallet_screen";
  static const String transactionHistory = "/transaction_history_screen";
  static const String bookAppointment = "/book_appointment_screen";
  static const String pathologyAndChemistForm =
      "/pathology_and_chemist_form_screen";
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
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case Routs.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Routs.signUp:
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(
                  arguments: arguments as SendArguments,
                ));

      case Routs.updateProfile:
        return MaterialPageRoute(
            builder: (_) => UpdateProfileScreen(
                  arguments: arguments as SendArguments,
                ));

      case Routs.otp:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
                  arguments: arguments as SendArguments,
                ));

      case Routs.mainHome:
        return MaterialPageRoute(builder: (_) => const MainHomeScreen());

      case Routs.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routs.myAppointment:
        return MaterialPageRoute(builder: (_) => const MyAppointmentScreen());

      case Routs.myOrder:
        return MaterialPageRoute(builder: (_) => const MyOrderScreen());

      case Routs.doctorList:
        return MaterialPageRoute(
            builder: (_) => DoctorProfileList(
                  arguments: arguments as SendArguments,
                ));

      case Routs.services:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());

      case Routs.specialistDoctor:
        return MaterialPageRoute(
            builder: (_) => SubCategoryDoctor(
                  arguments: arguments as SendArguments,
                ));

      case Routs.mobileVerification:
        return MaterialPageRoute(
            builder: (_) => const MobileVerificationScreen());

      case Routs.meetingSchedule:
        return MaterialPageRoute(builder: (_) => const MeetingSchedule());

      case Routs.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case Routs.termsAndCondition:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionScreen());
      case Routs.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case Routs.wallet:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case Routs.transactionHistory:
        return MaterialPageRoute(
            builder: (_) => const TransactionHistoryScreen());
      case Routs.bookAppointment:
        return MaterialPageRoute(
            builder: (_) => BookAppointmentScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.pathologyAndChemistForm:
        return MaterialPageRoute(
            builder: (_) => const PathologyAndChemistFormScreen());
      default:
        return null;
    }
  }
}
