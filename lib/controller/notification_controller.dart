import 'dart:convert';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/notification_model.dart';

class NotificationController extends GetxController {
  var notificationList = <NotificationModel>[].obs;
  notification() async {
    // var response = await DataBaseHelper.post(EndPoints.get_notification, {
    //   "user_id": Global.userModel?.id,
    // });
    http.Response response =
        await http.post(Uri.parse(EndPoints.get_notification),
            body: jsonEncode({
              "user_id": Global.userModel?.id,
            }),
            headers: await header);
    var parsedData = jsonDecode(response.body);
    // print('NOTIFYYYYY -----------        $parsedData');
    if (parsedData['statusCode'] == 200) {
      var list = (parsedData['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      notificationList.value = list;
      update();
    } else if (parsedData['statusCode'] == 401) {
      snackBar(parsedData['error']);
    } else {
      notificationList.value = [];
    }
  }

  updateNotification({String? notifyId}) async {
    // var response = await DataBaseHelper.post(EndPoints.update_notification,
    //     {"user_id": Global.userModel?.id, "notify_id": notifyId});
    http.Response response = await http.post(
        Uri.parse(EndPoints.update_notification),
        body: jsonEncode(
            {"user_id": Global.userModel?.id, "notify_id": notifyId}),
        headers: await header);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      // print(
      //     "PARSEDDDDDDAAAAAAAATTTTTTTTTTTTTTAAAAAAAAAAAAAAAA           --------------------             ${parsedData}");
      update();
      return parsedData;
    }
  }

  bool? notifyCount;
  countNotification() async {
    // loading(value: true);
    // print("COUNTNOTIFICATION ___________________________");
    // var response = await DataBaseHelper.post(
    //     EndPoints.count_notification, {"user_id": Global.userModel?.id});

    http.Response response = await http.post(
      Uri.parse(EndPoints.count_notification),
      body: jsonEncode({"user_id": Global.userModel?.id ?? "-1"}),
      headers: await header,
    );
    var parsedData = jsonDecode(response.body);
    // loading(value: false);
    if (parsedData['statusCode'] == 200) {
      notifyCount = parsedData['Notification'];
      update();
      // print(
      //     "COUNTNOTIFICATIONNNNNNNNNNNNNNNNNNNNNNNNNNN  200          --------------------             ${notifyCount}");
      return notifyCount;
    } else if (parsedData['statusCode'] == 400) {
      notifyCount = parsedData['Notification'];
      update();
      // print(
      //     "COUNTNOTIFICATIONNNNNNNNNNNNNNNNNNNNNNNNNNN   400         --------------------             ${notifyCount}");
      return notifyCount;
    }
  }
}
