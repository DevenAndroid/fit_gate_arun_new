// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/controller/subscription_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/main.dart';
import 'package:fit_gate/models/user_model.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/inro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/my_images.dart';
import 'auth/secondpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final loginCon = Get.put(LoginController());
  final mapController = Get.put(MapController());
  final activePlan = Get.put(SubscriptionController());
  var auth = FirebaseAuth.instance.authStateChanges();

  checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = await jsonDecode(pref.getString('isLogin').toString());
    var logout = await pref.getBool('isLogout');
    // print("SPLASH ----- $data");
    print("LOGOUT::$logout");
    print("^^^^^^^^^^^ $data");
    if (data != null) {
      // await mapController.getCurrentLocation();
      UserModel setData = UserModel.fromJson(data);
      Global.userModel = setData;
      // var plan = await activePlan.activeSubscriptionPlan();
      // print("SUB PLAN---> $plan");
      // if (plan == true) {
      //   ActiveSubscriptionModel activeData = ActiveSubscriptionModel.fromJson(
      //       await jsonDecode(pref.getString('isActivated').toString()));
      //   Global.activeSubscriptionModel = activeData;
      // }
      if (FirebaseAuth.instance.currentUser!.displayName.toString() != "true") {
        Get.offAll(() => UserInfoScreen());
        return;
      }

      await Future.wait<void>([
        loginCon.getUserById(),
        loginCon.checkUser(phoneNo: Global.userModel?.phoneNumber),
        activePlan.activeSubscriptionPlan(),
        mapController.getGym(),
      ]);

      if (Global.userModel?.deleteStatus == '1') {
        Timer(Duration(seconds: 1), () {
          Get.off(() => LoginScreen());
        });
      } else {
        Timer(Duration(seconds: 0), () {
          Get.off(() => BottomNavigationScreen());
        });
      }
    } else {
      isBoardingView == 1
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => IntroScreen());
    }
    // else if (delete == true) {
    //   print("SPLASH DELETE ==========  $delete");
    //   Timer(Duration(seconds: 0), () {
    //     Get.off(() => LoginScreen());
    //   });
    // } else if (logout == true) {
    //   Timer(Duration(seconds: 0), () {
    //     Get.off(() => LoginScreen());
    //   });
    // } else if (skip == true) {
    //   Get.off(() => BottomNavigationScreen());
    // } else {
    //   if (info == true) {
    //     Timer(Duration(seconds: 1), () {
    //       Get.off(() => SignUpScreen());
    //     });
    //   } else {
    //     Timer(Duration(seconds: 1), () {
    //       Get.off(() => InfoPage());
    //     });
    //   }
    // }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          MyImages.bg,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          left: 50,
          right: 50,
          top: MediaQuery.of(context).size.height * 0.14,
          child: Image.asset(
            MyImages.splashLogo,
            // color: MyColors.white,
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.75,
          ),
        ),
        // isDenied
        //     ? Positioned(
        //         bottom: 10,
        //         child: Text('data'),
        //       )
        //     : SizedBox(),
      ],
    ));
  }
}

// class InfoPage extends StatefulWidget {
//   final bool notNow;
//   const InfoPage({Key? key, this.notNow = false}) : super(key: key);
//
//   @override
//   State<InfoPage> createState() => _InfoPageState();
// }
//
// class _InfoPageState extends State<InfoPage> {
//   final mapController = Get.put(MapController());
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
//       child: GetBuilder<MapController>(builder: (controller) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(MyImages.location_bg),
//             SizedBox(height: 30),
//             Center(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       // widget.notNow == true
//                       //     ? "Location permission is mandatory"
//                       //     :
//                       "We'll need your location to give you a\n better experience",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           height: 1.5),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             /*Column(
//                 children: [
//                   permission == LocationPermission.denied ||
//                           permission == LocationPermission.deniedForever
//                       ? SizedBox()
//                       : Text(
//                           widget.notNow == true
//                               ? "Location permission is mandatory"
//                               : "We'll need your location to give you a",
//                           style:
//                               TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                   SizedBox(height: 5),
//                   permission == LocationPermission.denied ||
//                           permission == LocationPermission.deniedForever
//                       ? SizedBox()
//                       : Text(widget.notNow == true ? "" : "better experience",
//                           style:
//                               TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
//                   // SizedBox(height: 5),
//                   // widget.notNow == true
//                   //     ? Text('so please enable the location service and try again.',
//                   //         style:
//                   //             TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
//                   //     : permission == LocationPermission.denied ||
//                   //             permission == LocationPermission.deniedForever
//                   //         ? Text("saa")
//                   //         : Text('sas',
//                   //             style: TextStyle(
//                   //                 fontSize: 15, fontWeight: FontWeight.w500)),
//                 ],
//               ),*/
//             SizedBox(height: 30),
//             mapController.permission == LocationPermission.denied ||
//                     mapController.permission == LocationPermission.deniedForever
//                 ? FloatingActionButton(
//                     onPressed: () async {
//                       var pref = await SharedPreferences.getInstance();
//                       snackbarKey.currentState?.hideCurrentSnackBar();
//                       await pref.setBool('isInfo', true);
//                       push(
//                           context: context,
//                           screen: SignUpScreen(),
//                           pushUntil: true);
//                     },
//                     backgroundColor: MyColors.orange,
//                     child: Icon(Icons.arrow_forward),
//                   )
//                 : Column(
//                     children: [
//                       Center(
//                         child:
//                             /* permission == LocationPermission.denied ||
//                             permission == LocationPermission.deniedForever
//                         ? Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                         'Location permission is mandatory in order to show you the gyms near you so please enable the location service and try again.',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             height: 1.5)),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               CustomButton(
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 title: "Take me to location settings",
//                                 fontSize: 16,
//                                 onTap: () async {
//                                   openAppSettings();
//                                 },
//                               )
//                             ],
//                           )
//                         : */
//                             CustomButton(
//                           width: MediaQuery.of(context).size.width * 0.5,
//                           title: "Sure,I'd like that",
//                           fontSize: 16,
//                           onTap: () async {
//                             var pref = await SharedPreferences.getInstance();
//                             await mapController.getCurrentLocation();
//                             // if (mapController.permission == LocationPermission.denied ||
//                             //     mapController.permission ==
//                             //         LocationPermission.deniedForever) {
//                             //   snackBar("Location permissions are denied",
//                             //       color: Colors.black.withOpacity(.80));
//                             //   setState(() {});
//                             // } else {
//                             await pref.setBool('isInfo', true);
//                             push(
//                                 context: context,
//                                 screen: SignUpScreen(),
//                                 pushUntil: true);
//                             print('qqq ${await pref.setBool('isInfo', true)}');
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // widget.notNow == true
//                       //     ? SizedBox()
//                       //     : permission == LocationPermission.denied ||
//                       //             permission == LocationPermission.deniedForever
//                       //         ? SizedBox()
//                       //         :
//                       Center(
//                         child: CustomButton(
//                           // width: MediaQuery.of(context).size.width * 0.5,
//                           borderColor: Colors.transparent,
//                           bgColor: Colors.transparent,
//                           fontColor: MyColors.black,
//                           title: "Not now",
//                           fontSize: 15,
//                           onTap: () async {
//                             print('LAT ${mapController.latitude}');
//                             print('LNG ${mapController.longitude}');
//                             var pref = await SharedPreferences.getInstance();
//                             await pref.setBool('isInfo', true);
//                             push(
//                                 context: context,
//                                 screen: SignUpScreen(),
//                                 pushUntil: true);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//           ],
//         );
//       }),
//     ));
//   }
// }
