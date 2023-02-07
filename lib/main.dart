import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:doctor_on_call/routs/app_routs.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/utils/theme_utils.dart';
import 'package:doctor_on_call/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'commonMethod/notification.dart';
import 'commonMethod/storage_handler.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await AppNotificationHandler.firebaseNotificationSetup();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  try {
    String? token = await firebaseMessaging.getToken().catchError((e) {
      log("=========1fcm- Error ....:$e");
    });
    await PreferenceManager.setFcmToken(token!);
    log("=========2fcm-token===>>  $token");
  } catch (e) {
    log("=========3fcm- Error :$e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeUtils.lightTheme,
      initialRoute: Routs.splash,
      onGenerateRoute: RoutGenerator.generateRoute,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const _ScrollBehaviorModified(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              ScreenUtil.init(constraints,
                  designSize:
                      Size(constraints.maxWidth, constraints.maxHeight));
              child = botToastBuilder(context, child);
              return child ?? const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

class _ScrollBehaviorModified extends ScrollBehavior {
  const _ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
