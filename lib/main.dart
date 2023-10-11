// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/controller/subscription_controller.dart';
import 'package:fit_gate/firebase_notification.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/splash_screen.dart';
import 'package:fit_gate/test.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check_connection.dart';
import 'utils/notification_service.dart';

int? isBoardingView;

Future<void> main() async {
  var connection = Get.put(ConnectivityService());
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeNotification();
  await connection.initConnectivity();
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        name: "fitgate",
        options: FirebaseOptions(
          apiKey: "AIzaSyDqrqo9k7Q733zw5rNI0pQqP5AXW6UGOoU",
          authDomain: "fitgate-b4390.firebaseapp.com",
          projectId: "fitgate-b4390",
          storageBucket: "fitgate-b4390.appspot.com",
          messagingSenderId: "19639569626",
          appId: "1:19639569626:web:b01fde993ee4456e52e9e3",
          measurementId: "G-THSCG2PSXM",
        ));
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await PurchaseSub.init();

  // isBoardingView = prefs.getInt('intro');
  // print("$isBoardingView");
  notification();

  runApp(MyApp());
}

notification() async {
  var pref = await SharedPreferences.getInstance();
  var turnOnNotification = await pref.getBool('isNotifyOn');
  if (turnOnNotification == true || turnOnNotification == null) {
    await FirebaseNotification.init();
    // await LocalNotification.init();
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MapController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: GetMaterialApp(
          title: "Fit Gate",
          theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyColors.grey.withOpacity(.5)),
          ),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
