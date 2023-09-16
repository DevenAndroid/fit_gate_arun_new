import 'dart:convert';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';

class DeleteUserController extends GetxController {
  Future<bool> deleteUser(String? id) async {
    var response = await DataBaseHelper.post(EndPoints.deleteUser, {
      "id": id,
    });

    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
