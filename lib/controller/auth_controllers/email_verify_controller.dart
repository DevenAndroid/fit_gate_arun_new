import 'dart:convert';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController {
  String? verifysw;

  Future<bool> emailVerification({String? email, String? code}) async {
    var response = await DataBaseHelper.post(
      EndPoints.checkEmailVerification,
      {"email": email, "code": code},
    );
    var parsedData = jsonDecode(response.body);
    print("@@@@@@@@@@   ==   ${verifysw}");
    if (parsedData['statusCode'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  sendEmailVerification({String? email, String? userId}) async {
    var data = {"user_id": userId, "email": email};
    var response =
        await DataBaseHelper.post(EndPoints.sendVerificationEmail, data);
    print("EMAIL ENCODE-->  ${jsonEncode(data)}");
    var parsedData = jsonDecode(response.body);
    print(Global.userModel?.id);
    if (parsedData['statusCode'] == 200) {
      verifysw = parsedData['data']['email'];
      print("VERIFY EMAIL   ==   ${verifysw}");
      update();
      return true;
    } else {
      return false;
    }
  }

  resendEmail({String? email}) async {
    var response =
        await DataBaseHelper.post(EndPoints.resendEmailVerification, {
      "email": email,
    });

    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      print("CODE Email Ver -----  $parsedData");
      return true;
    } else {
      return false;
    }
  }
}
