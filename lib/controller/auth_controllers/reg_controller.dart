// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/models/user_model.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/auth/secondpage.dart';

class RegisterController extends GetxController {
  var auth = FirebaseAuth.instance;
  final mapController = Get.put(MapController());

  regUser(
    context, {
    String? phone,
    String? verificationId,
    String? code,
    String? companyId,
    String? fcmToken,
    String? countryCode,
  }) async {
    try {
      print("TRYYYYYYYY ------");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: code!);
      await auth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          await registerApiCall(phone, context, companyId, fcmToken, countryCode);
        } else {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (_) => JoinFitGatePage()),
          //     (route) => false);
        }
      });
    } on FirebaseAuthException catch (e) {
      print('!!!!!!!!!!!!!!!! ${e.code}');
      if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid OTP"),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ));
      }
      // return snackBar("$e");
    }
    // print("USER ID :::: ${auth.currentUser!.uid}");
  }

  registerApiCall(phone, context, companyId, fcmToken, countryCode) async {
    loading(value: true);
    var pref = await SharedPreferences.getInstance();
    var data = {
      "phone_number": phone,
      "type": 'citizen',
      "firebase_id": auth.currentUser!.uid,
      "company_id": companyId,
      "fcm_token": fcmToken,
      "country_code": countryCode,
    };
    try {
      var response = await DataBaseHelper.post(EndPoints.registration, data);
      var parsedData = jsonDecode(response.body);

      print("PARSED DATA REGGGG --- $parsedData");
      print("ENCODE REG DATA --- ${jsonEncode(data)}");
      if (parsedData['statusCode'] == 200) {
        loading(value: false);
        Global.userModel = UserModel.fromJson(parsedData['data']);
        pref.setString('isLogin', jsonEncode(parsedData['data']));
        await mapController.getCurrentLocation();
        await mapController.getGym();
        await mapController.getFilterData(
          isCurrentLocation: true,
          lat: mapController.currentLatitude.toString(),
          lon: mapController.currentLongitude.toString(),
          // lat: 26.4334567.toString(),
          // lon: 50.5327707.toString(),
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => UserInfoScreen()), (route) => false);
      }
    } catch (e) {
      loading(value: false);
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("parsedData['message']"),
    //     backgroundColor: Colors.red.shade700,
    //     duration: Duration(seconds: 2),
    //   ));
    //   return false;
    // }
  }
}

/*try {
      print("TRYYYYY ");
      await auth.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("VERIFICATION COMPLETED");
          try {
            var credential = PhoneAuthProvider.credential(
                verificationId: verificationId!, smsCode: code!);
            await auth.signInWithCredential(credential).then((value) {
              if (value.user != null) {
                print("USERRRRRR ${value.user}");
                Get.off(() => BottomNavigationScreen());
              } else {
                // Get.off(() => JoinFitGatePage());
              }
            });
          } catch (e) {
            print(e);
            return toast("Invalid OTP");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("FAILEDDDDD");
          print("ERORRRRR $e");
        },
        codeSent: (String? verificationID, int? resendToken) {
          print("CODE SENT");
          Get.to(() => VerifyPhoneScreen(
                verificationId: verificationID,
                phone: phone,
              ));
        },
        codeAutoRetrievalTimeout: (String? verificationId) {
          update();
          // verificationCode = verificationId;
          print("TIME OUT");
          // print("VERIFICATION ID${verificationId}");
        },
        timeout: Duration(seconds: 30),
      );
    } catch (e) {
      print("ERRORRRRRRR $e");
    }*/
