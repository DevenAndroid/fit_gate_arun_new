// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class LoginController extends GetxController {
  var auth = FirebaseAuth.instance;

  // var checkPhone;
  Future<bool> userLogin(String? phone, String? fcmToken) async {
    loading(value: true);
    var pref = await SharedPreferences.getInstance();

    var data = {
      "phone_number": phone,
      "type": "citizen",
      "fcm_token": fcmToken,
    };

    var response = await DataBaseHelper.post(EndPoints.login, data);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      loading(value: false);
      Global.userModel = UserModel.fromJson(parsedData['data']);
      pref.setString("isLogin", jsonEncode(parsedData['data']));

      await MapController().getFilterData(
        isCurrentLocation: true,
        lat: MapController().currentLatitude.toString(),
        lon: MapController().currentLongitude.toString(),
        // lat: 26.4334567.toString(),
        // lon: 50.5327707.toString(),
      );

      update();
      return true;
    } else {
      loading(value: false);
      return false;
    }
  }

  Future<bool> checkPhoneNo({String? phoneNo}) async {
    loading(value: true);
    http.Response response = await http.post(Uri.parse(EndPoints.checkPhoneNo),
        body: jsonEncode({"phone_number": phoneNo}), headers: await header);

    var parsedData = jsonDecode(response.body);
    print(parsedData);
    if (parsedData['statusCode'] == 200) {
      loading(value: false);
      // print("CHECKPHONEEE -----------     }");
      return true;
    } else {
      // isLogin == true ? ""
      loading(value: false);
      showToast(parsedData['message']);
      return false;
    }
  }

  Future<bool> checkUser({String? phoneNo}) async {
    http.Response response = await http.post(Uri.parse(EndPoints.checkUser),
        body: jsonEncode({"phone_number": phoneNo}), headers: await header);
    print("CHECKPHONEEE -----------     ${response.body}");

    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      return true;
    } else {
      showToast(parsedData['message'].toString());
      return false;
    }
  }

  getUserById() async {
    // loading(value: true);
    http.Response response = await http.post(
      Uri.parse(EndPoints.getUserById),
      body: jsonEncode({"user_id": Global.userModel?.id}),
      headers: await header,
    );
    // log(""
    //     "Api Response......         ${response.body}");
    var parsedData = jsonDecode(response.body);
    var pref = await SharedPreferences.getInstance();
    if (parsedData['statusCode'] == 200) {
      // loading(value: false);
      Global.userModel = UserModel.fromJson(parsedData['data']);
      pref.setString('isLogin', jsonEncode(parsedData['data']));
      update();
      return true;
    } else {
      return false;
    }
  }
}
