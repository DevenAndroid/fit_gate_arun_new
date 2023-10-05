import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../global_functions.dart';
import '../models/userinfo_model.dart';

Future<UserInfoModal> userinfoRepo({
  required fcm_token,
  required area,
  required fname,
  required lname,
  required gender,
  required dob,
  required country_name,
}) async {
  try {
    print(await header);
    loading(value: true);
    var map = <String, dynamic>{};

    map['fcm_token'] = fcm_token;
    map['area'] = area;
    map['user_id'] = Global.userModel!.id.toString();
    map['fname'] = fname;
    map['lname'] = lname;
    map['gender'] = gender.toString().toLowerCase();
    map['dob'] = dob;
    map['country_name'] = country_name;

    print(map);

    http.Response response = await http.post(Uri.parse("https://admin.fitgate.live/api/register-two"),
        headers: await header, body: jsonEncode(map));
    log("Sign IN DATA${map}");
    log("Sign IN DATA${await header}");
    log("Sign IN DATA${response.body}");
    loading(value: false);
    var parsedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      print("data submitted");
      if (parsedData['message'] != "Updated successfully") {
        showToast("Please fill all details");
      }
      return UserInfoModal.fromJson(jsonDecode(response.body));
    } else {
      print("%%%%% ${jsonDecode(response.body)}");
      return UserInfoModal(
        message: jsonDecode(response.body)["message"],
      );
    }
  } catch (e) {
    loading(value: false);
    throw Exception(e);
  }
}
