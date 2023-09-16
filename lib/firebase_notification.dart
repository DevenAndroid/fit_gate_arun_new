import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'local_notification.dart';
import 'utils/notification_service.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if(message.notification != null) {
    NotificationService().showSimpleNotification(title: message.notification!.title.toString(), body: message.notification!.body.toString());
  }
  if (kDebugMode) print("Handling a background message: ${message.messageId}");
}

class FirebaseNotification {
  static init() {
    // FirebaseMessaging.instance.getToken().then((value) => print(value));
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log("Notification Recieved................     ");
      if (message != null) {
        // Fluttertoast.showToast(msg: "ON App Open");
        // Fluttertoast.showToast(msg: "ON App Open");
        // Fluttertoast.showToast(msg: "${message.notification!.body}");      Fluttertoast.showToast(msg: "${message.notification!.title}");
        // Fluttertoast.showToast(msg: "${message.data}");
        // Fluttertoast.showToast(msg: "ON App Open");
        // Fluttertoast.showToast(msg: "ON App Open");
        // print("ON App Open");
        // print("ON App Open");
        // Map<String, dynamic> data = message.data;
        // print("ON APP OPEN !!!!!!!!!!!!! $data");
        // log('$data');
        if(message.notification != null) {
          NotificationService().showSimpleNotification(title: message.notification!.title.toString(), body: message.notification!.body.toString());
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Notification Recieved................     ");
      if(message.notification != null) {
        NotificationService().showSimpleNotification(title: message.notification!.title.toString(), body: message.notification!.body.toString());
      }
      // message.data;
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // // Fluttertoast.showToast(msg: "APPLE MANGO");
      // // Fluttertoast.showToast(msg: "APPLE MANGO");
      // // Fluttertoast.showToast(msg: "${message.notification!.body}");
      // // Fluttertoast.showToast(msg: "${message.notification!.title}");
      // // Fluttertoast.showToast(msg: "${message.data}");
      // // Fluttertoast.showToast(msg: "APPLE MANGO");
      // // Fluttertoast.showToast(msg: "APPLE MANGO");
      // LocalNotification.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification Recieved................     ");

      if(message.notification != null) {
        NotificationService().showSimpleNotification(title: message.notification!.title.toString(), body: message.notification!.body.toString());
      }
      // message.data;
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // log("App Open");
      // log("App Open");
      // log("App Open");
      // // print("On APP OPENDED");
      // // print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");print("On APP OPENDED");
      // // Fluttertoast.showToast(msg: "No App Open");
      // // Fluttertoast.showToast(msg: "No App Open");
      // // Fluttertoast.showToast(msg: "${message.notification!.body}");
      // // Fluttertoast.showToast(msg: "${message.notification!.title}");
      // // Fluttertoast.showToast(msg: "${message.data}");
      // // Fluttertoast.showToast(msg: "No App Open");
      // // Fluttertoast.showToast(msg: "No App Open");
      // /* Map<String,dynamic> data = message.data;
      // if (data['notification']['type'] != "chat") {
      //   LocalNotification.showNotification(message);
      // }*/
      //
      // LocalNotification.showNotification(message);
    });
  }
}
