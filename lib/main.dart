import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app_intitial/view/app.dart';
import 'services/shared_prefrance_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ErrorWidget.builder = (details) => MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   theme: ThemeData(useMaterial3: true),
  //       home: Scaffold(
  //         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  //         body: Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Icon(
  //                 Icons.warning,
  //                 color: Colors.white,
  //                 size: 80,
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 details.exception.toString(),
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(fontSize: 27),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
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
        child: const MyApp()),
  );
}
