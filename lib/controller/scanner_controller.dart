// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/activity_log_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'check_in_controller.dart';

class ScannerController extends GetxController {
  QRViewController? controller;
  Barcode? barcode;
  final bottomController = Get.put(BottomController());
  var checkInController = Get.put(CheckInController());
  var isCheckIn;
  bool loadionmg = false;

  scanQr(context, {QRViewController? qrViewController}) {
    update();
    controller = qrViewController;
    qrViewController?.scannedDataStream.listen((code) async {
      update();
      barcode = code;
      controller?.dispose();
      if(loadionmg == true){
        return;
      }
      loadionmg = true;
      String gg = "";
      try {
        gg = await scannerQR(context, qrId: barcode!.code);
      } catch(e){
        loadionmg = false;
      }
      loadionmg = false;
      if (isCheckIn == false) {
        bottomController.setSelectedScreen(true,
            screenName: ActivityLogsScreen(
              result: barcode!.code,
            ));
        return snackBar(gg);
      }
      await checkInController.checkInLog();
      print("CODE      ________++++++++++${barcode?.code}");
      bottomController.setSelectedScreen(true,
          screenName: ActivityLogsScreen(
            result: barcode!.code,
          ));
      Get.to(() => BottomNavigationScreen());
      return snackBar(gg);
    });
    qrViewController?.pauseCamera();
    qrViewController?.resumeCamera();
  }

  Future<String> scannerQR(context, {String? qrId}) async {
    http.Response response = await http.post(
      Uri.parse(EndPoints.checkIn),
      body: jsonEncode({"user_id": Global.userModel?.id, "qr_id": qrId}),
      headers: await header,
    );
    print("Goodwork${qrId}");
    print("Responce.......   ${response.body}");


    var parsedData = jsonDecode(response.body);
    print("QR IDD +++++++++++   ${qrId}");
    if (response.statusCode == 200) {
      if (parsedData['statusCode'] == 400) {
        isCheckIn = parsedData['isCheckin'];
        // if (parsedData['isCheckin'] == false) {
        //   return snackBar(parsedData['message']);
        // }
      }
    }
    return parsedData['message'] ?? "Something went wrong.";
  }
}
