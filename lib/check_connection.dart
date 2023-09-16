import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  static final ConnectivityService _check = ConnectivityService._internal();
  final service = Get.put(MapController());
  factory ConnectivityService() {
    return _check;
  }
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;

  Future<void> initConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      _isConnected = false;
      update();
    } else {
      _isConnected = true;
      update();
    }
    print("CONNECTION RESULT--> $result");
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
        update();
      } else {
        _isConnected = true;
        update();
      }
    });
  }

  bool get isConnected => _isConnected;

  checkConnection() {
    return _check._isConnected;
  }
}

class CheckConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var connection = Get.put(ConnectivityService());

    final bool isConnected = connection.checkConnection();
    return GetBuilder<ConnectivityService>(builder: (con) {
      return Container(
        padding: EdgeInsets.all(0),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.red.shade300),
        child: Visibility(
          visible: isConnected ? false : true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MyImages.no_connection, height: 18, width: 18),
              SizedBox(width: 5),
              Text(
                isConnected ? 'Connected' : 'No Internet Connection',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
    });
  }
}
