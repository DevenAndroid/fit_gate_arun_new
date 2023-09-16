import 'dart:convert';
import 'dart:developer';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'auth_controllers/login_controller.dart';

class ProfileController extends GetxController {
  addProfile(
      {String? name,
      String? email,
      String? gender,
      String? avatar,
      String? mName,
      required String area,
      required String dob,
      required String country_name,
      String? lName,
      String? subscriptionType,
      isEmail}) async {
    loading(value: true);

    var map = {
      "id": Global.userModel?.id,
      "name": name,
      "phone_number": Global.userModel?.phoneNumber,
      "email": email,
      "middle_name": mName,
      "last_name": lName,
      "gender": gender,
      "avatar": avatar,
      "subscription_type": subscriptionType,
      "area" : area,
      "dob" : dob,
      "country_name" : country_name,
    };
    try {
      log("Sending data......      $map");
      http.Response response = await http.post(Uri.parse(EndPoints.profile),
          body: jsonEncode(map),
          headers: await header);

      loading(value: false);
      log("Receiving data......      ${response.body}");
      // var response = await DataBaseHelper.post(EndPoints.profile, {
      //   "id": Global.userModel?.id,
      //   "name": name,
      //   "phone_number": Global.userModel?.phoneNumber,
      //   "email": email,
      //   "middle_name": mName,
      //   "last_name": lName,
      //   "gender": gender,
      //   "avatar": avatar
      // });
      var parsedData = jsonDecode(response.body);
      if (parsedData['statusCode'] == 200) {
        var loginController = Get.put(LoginController());
        await loginController.getUserById();
        update();
        isEmail == true
            ? ""
            : snackBar("Profile updated", color: Colors.green.shade600);
        return parsedData;
      } else if (parsedData['statusCode'] == 401) {
        snackBar(parsedData['error']);
      }
    } catch(e){
      loading(value: false);
    }
  }
}
