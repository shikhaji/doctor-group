import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();
  static String fcmToken = 'FCM_TOKEN';

  ///FCM TOKEN
  static Future setFcmToken(String value) async {
    await getStorage.write(fcmToken, value);
  }

  static String getFcmToken() {
    return getStorage.read(fcmToken);
  }
}
