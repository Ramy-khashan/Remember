// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/timezone.dart' as tz;

// // class NotificationService {
// //   static final NotificationService _notificationService =
// //       NotificationService._internal();

// //   factory NotificationService() {
// //     return _notificationService;
// //   }

// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   NotificationService._internal();

// //   Future<void> initNotification() async {
// //     const AndroidInitializationSettings initializationSettingsAndroid =
// //         AndroidInitializationSettings('@drawable/launch_background');

// //     const IOSInitializationSettings initializationSettingsIOS =
// //         IOSInitializationSettings();

// //     const InitializationSettings initializationSettings =
// //         InitializationSettings(
// //             android: initializationSettingsAndroid,
// //             iOS: initializationSettingsIOS);

// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //         onSelectNotification: (payload) {});
// //   }

// //   Future<void> showNotification(
// //       {required int id,
// //       required String title,
// //       required String body,
// //       required int minute}) async {
// //     await flutterLocalNotificationsPlugin.zonedSchedule(
// //       id,
// //       title,
// //       body,
// //       tz.TZDateTime.now(tz.local)
// //           .add(Duration(seconds: minute <= 0 ? 2 : minute * 60)),
// //       const NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           'main_channel',
// //           'Main Channel',
// //           channelDescription: 'Main channel notifications',
// //           importance: Importance.max,
// //           priority: Priority.max,
// //           icon: '@drawable/launch_background',
// //           // ongoing: true,
// //           //
// //           // styleInformation: BigTextStyleInformation(''),
// //         ),
// //         iOS: IOSNotificationDetails(
// //           presentAlert: true,
// //           presentBadge: true,
// //           presentSound: true,
// //         ),
// //       ),
// //       uiLocalNotificationDateInterpretation:
// //           UILocalNotificationDateInterpretation.absoluteTime,
// //       androidAllowWhileIdle: true,
// //     );
// //   }

// //   Future<void> cancelAllNotifications() async {
// //     await flutterLocalNotificationsPlugin.cancelAll();
// //   }

// //   Future<void> cancelNotification({required int id}) async {
// //     await flutterLocalNotificationsPlugin.cancel(id);
// //   }
// // }
// import 'dart:io';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 
// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/launch_background');
//     IOSInitializationSettings? initializationSettingsIOS;
//     if (Platform.isIOS) {
//       initializationSettingsIOS = const IOSInitializationSettings();
//     }

//     InitializationSettings initializationSettings = Platform.isAndroid
//         ? const InitializationSettings(android: initializationSettingsAndroid)
//         : InitializationSettings(iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestPermission();
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   AndroidNotificationDetails androidNotificationDetails =
//       const AndroidNotificationDetails(
//     'default_notification_channel_id',
//     'Default',
//     importance: Importance.max,
//     priority: Priority.max,
//   );

//   Future<void> showNotification(
//       {required int id,
//       required String title,
//       required String body,
//         int?minute}) async {
//      await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       // tz.TZDateTime.now(tz.local)
//       //     .add(Duration(seconds: minute <= 0 ? 2 : minute * 60)),
//       const NotificationDetails(
//           android: AndroidNotificationDetails(
//               'your channel id', 'your channel name', ongoing: true,
//               channelDescription: 'your channel description')),
//       // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       // matchDateTimeComponents: DateTimeComponents.dateAndTime,
//       // uiLocalNotificationDateInterpretation:
//       //     UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true
//     );
//     // await
//     //  flutterLocalNotificationsPlugin.zonedSchedule(
//     //   id,
//     //   title,
//     //   body,
//     //   tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
//     //   // tz.TZDateTime.now(tz.local)
//     //   //     .add(Duration(seconds: minute <= 0 ? 2 : minute * 60)),
//     //   Platform.isAndroid
//     //       ? NotificationDetails(
//     //           android: androidNotificationDetails,
//     //         )
//     //       : const NotificationDetails(
//     //           iOS: DarwinNotificationDetails(
//     //             presentAlert: true,
//     //             presentBadge: true,
//     //             presentSound: true,
//     //           ),
//     //         ),
//     //  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

//     //     uiLocalNotificationDateInterpretation:
//     //     UILocalNotificationDateInterpretation.absoluteTime
//     // );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   Future<void> cancelNotification({required int id}) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
// }
