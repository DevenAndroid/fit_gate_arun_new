import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets/dialog/custom_dialog.dart';
import '../global_functions.dart';
import '../models/common_model.dart';
import '../models/payment_model.dart';
import '../models/subscription_model.dart';


Future<SubscriptionModel> subscriptionDataRepo({required id , context}) async {

  var apiUrl = "https://admin.fitgate.live/api/get-subscription-list";
  // OverlayEntry loader = CustomDialog.overlayLoader(context);
  http.Response response =
  await http.get(Uri.parse("${apiUrl}?id=$id"), headers: await header,);
  log("${apiUrl}?id=$id");
  if (response.statusCode == 200) {
    log("<<<<<<<Subscription list repository=======>${response.body}");
    return SubscriptionModel.fromJson(json.decode(response.body));
  } else {
    // CustomDialog.hideShimmer(loader);
    throw Exception(response.body);
  }
}


//Gym details repo
Future<ModelCommonResponse> gymDetailsRepo({required userId,required cprNumber, required planEmail}) async {

  var apiUrl = "https://admin.fitgate.live/api/gym-details";
  var map = <String, dynamic>{};
  map['user_id']= userId;
  map['plan_email']= planEmail;
  map['cpr_no']= cprNumber;

  log(map.toString());
  http.Response response =
  await http.post(Uri.parse("${apiUrl}"), headers: await header, body: jsonEncode(map));

  if (response.statusCode == 200) {
    // loading(value: false);
    print("<<<<<<<Subscription list repository=======>${response.body}");
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    // loading(value: false);
    throw Exception(response.body);
  }
}

// payment api for generate the link
Future<PaymentModel> givePaymentInfo({required planAmt,required userId, required subscriptionId,required gymId}) async {

  var apiUrl = "https://admin.fitgate.live/api/generate-link";
  var map = <String, dynamic>{};
  map['amt']= planAmt;
  map['user_id']= userId;
  map['subscription_id']= subscriptionId;
  map['gym_id']= gymId;

  log(map.toString());
  http.Response response =
  await http.post(Uri.parse("${apiUrl}"), headers: await header, body: jsonEncode(map));
  print("PAYMENT DETAILS=======>${response.body}");

  if (response.statusCode == 200) {
    // loading(value: false);
    return PaymentModel.fromJson(json.decode(response.body)[0]);
  } else {
    // loading(value: false);
    throw Exception(response.body);
  }
}
