import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../global_functions.dart';

class DataBaseHelper {
  static Future<http.Response> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    http.Response? response;
    try {
      // loading(value: true);
      response = await http.post(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer ${Global.userModel?.id}"
        },
      );

      var parsedData = jsonDecode(response.body);
      print("PARSEDDD ----------------     ${parsedData}");
      switch (parsedData['statusCode']) {
        case 200:
          loading(value: false);
          // toast(parsedData['message']);
          return response;
        case 201:
          loading(value: false);
          // toast(parsedData['message']);
          return response;
        case 204:
          loading(value: false);
          // toast(parsedData['message']);
          return response;
        case 400:
          loading(value: false);
          snackBar(parsedData['message']);
          // toast(parsedData['message']);
          return response;
        case 401:
          loading(value: false);
          snackBar(parsedData['error']);
          return response;
        case 500:
          loading(value: false);
          snackBar("Something went wrong");
          return response;
        default:
          return response;
      }
    } catch (e) {
      loading(value: false);
      return response!;
    }
  }

  static Future<http.Response> get(
    String path,
  ) async {
    loading(value: true);
    http.Response response = await http.get(
      Uri.parse(path),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${Global.userModel?.id}"
      },
    );
    var parsedData = jsonDecode(response.body);

    // print(parsedData);
    switch (parsedData['statusCode']) {
      case 200:
        loading(value: false);

        return response;
      case 201:
        loading(value: false);
        return response;
      case 204:
        loading(value: false);
        return response;
      case 400:
        loading(value: false);
        return response;
      case 401:
        loading(value: false);
        snackBar(parsedData['error']);
        return response;
      case 500:
        loading(value: false);
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          title: "Something went wrong",
        ));
        return response;
      default:
        return response;
    }
  }
}
