import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'config/app/view/app.dart';
import 'core/utils/shared_prefrance_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);
  await PreferenceUtils.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
        ],
        fallbackLocale: const Locale('ar', 'DZ'),
        path: 'assets/lang',
        child: const RememberApp()),
  );
}
