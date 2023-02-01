import 'package:bot_toast/bot_toast.dart';
import 'package:doctor_on_call/routs/app_routs.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/utils/theme_utils.dart';
import 'package:doctor_on_call/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
