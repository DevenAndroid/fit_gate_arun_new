import 'dart:convert';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/models/check_in_model.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets/dialog/custom_dialog.dart';

class CheckInController extends GetxController {
  var checkInList = <CheckInModel>[].obs;

  checkInLog() async {
    print(jsonEncode({
      "user_id": Global.userModel?.id,
    }));
    loading(value: true);
    http.Response response = await http.post(Uri.parse(EndPoints.checkInLog),
        body: jsonEncode({
          "user_id": Global.userModel?.id,
        }),
        headers: await header);
    var parsedData = jsonDecode(response.body);
    loading(value: false);
    if (parsedData['statusCode'] == 200) {
      var list = (parsedData['data'] as List)
          .map((e) => CheckInModel.fromJson(e))
          .toList();
      checkInList.value = list;
      print(
          "CHECK IN USERRRR +|+++++++++++++++++++++++++++++++  ${parsedData}");
      update();
    } else if (parsedData['statusCode'] == 401) {
      snackBar(parsedData['error']);
    } else {
      checkInList.value = [];
    }
  }
}
