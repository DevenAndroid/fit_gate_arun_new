// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotification {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//
//   static Future _notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         "channelId",
//         "channelName",
//         importance: Importance.max,
//         playSound: true,
//       ),
//       // iOS: IOSNotificationDetails(),
//     );
//   }
//
//   static Future init() async {
//     final android = AndroidInitializationSettings('@mipmap/launcher_icon');
//     // final iOS = IOSInitializationSettings();
//     final settings = InitializationSettings(android: android);
//     // _notifications.initialize(settings, onSelectNotification: (payload) {
//     //
//     // print("On CLick");
//     // Map<String,dynamic> data = jsonDecode(payload!);
//     // print("CTA:${data["cta"]}");
//     // print("TOKEN:${data["token"]}");
//     // });
//   }
//
//   /*onDidReceiveLocalNotification(BuildContext context,
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//
//
//           },
//         )
//       ],
//     ),
//   );
// }
// */
//   static Future showNotification(RemoteMessage message) async {
//     Map<String, dynamic> data = message.data;
//     print(data['notification']);
//     print(data);
//     print(data['body']);
//     print(data['title']);
//
//     int id = 0;
//     return await _notifications.show(id, message.data['title'],
//         message.data['body'], await _notificationDetails(),
//         payload: message.data['title']);
//     //return await _notifications.show(id, message.notification!.title,message.notification!.body,await _notificationDetails(),payload: data['notification'].toString());
//   }
// }
