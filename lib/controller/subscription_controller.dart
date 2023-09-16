import 'dart:convert';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/active_subscription_model.dart';
import '../models/subscription_list_model.dart';

class SubscriptionController extends GetxController {
  var subscriptionList = <SubscriptionListModel>[].obs;
  payment(
      {String? name,
      String? userId,
      String? amount,
      String? cprNo,
      String? subType}) async {
    var response = await DataBaseHelper.post(EndPoints.paymentSystem, {
      "name": name,
      "user_id": userId,
      "subscription_type": subType,
      "amount": amount,
      "cpr_no": cprNo,
    });
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      return parsedData;
    } else {
      return [];
    }
  }

  subscriptionListGet() async {
    var response = await DataBaseHelper.post(
        EndPoints.subscriptionList, {"user_id": Global.userModel?.id});
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      var list = (parsedData['data'] as List)
          .map((e) => SubscriptionListModel.fromJson(e))
          .toList();
      update();
      return subscriptionList.value = list;
    } else {
      return subscriptionList.value = [];
    }
  }

  Future<bool> activeSubscriptionPlan() async {
    var pref = await SharedPreferences.getInstance();
    http.Response response = await http.post(
        Uri.parse(EndPoints.activeSubscription),
        body: jsonEncode({}),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer ${Global.userModel?.id}"
        });
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      Global.activeSubscriptionModel =
          ActiveSubscriptionModel.fromJson(parsedData['data']);
      pref.setString('isActivated', jsonEncode(parsedData['data']));
      update();
      ActiveSubscriptionModel activeData = ActiveSubscriptionModel.fromJson(
          await jsonDecode(pref.getString('isActivated').toString()));
      Global.activeSubscriptionModel = activeData;
      print("SUB PLAN---> $activeData");
      return true;
    } else {
      // update();
      return false;
    }
  }

  Future updateSubscription({String? id, String? subId}) async {
    var data = {
      "id": id,
      "subscription_id": subId,
    };
    var response =
        await DataBaseHelper.post(EndPoints.updateSubscription, data);
    var parsedData = jsonDecode(response.body);
    print('DATA ENCODEE ------------------------ ${jsonEncode(data)}');
    if (parsedData['statusCode'] == 200) {
      // snackBar("Plan is successfully updated", color: Colors.green.shade600);
      return parsedData;
    } else {
      return [];
    }
  }

  Future<bool> deleteSubscriptionPlan(id) async {
    http.Response response = await http.post(
        Uri.parse(EndPoints.deleteSubscription),
        body: jsonEncode({"subscription_id": id}),
        headers: await header);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      snackBar("Plan is successfully deleted");
      return true;
    } else {
      return false;
    }
  }
}
