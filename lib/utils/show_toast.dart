import 'package:doctor_on_call/utils/app_color.dart';
import 'package:get/get.dart';


void showToast({required String title, bool status = false}) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 3),
    message: title,
    backgroundColor: status ? AppColor.green :AppColor.red,
  ));
}
