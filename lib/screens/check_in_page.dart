// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/screens/bottom_bar_screens/home_page.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/scanner_controller.dart';
import '../global_functions.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  var qrController = Get.put(ScannerController());
  var bottomController = Get.put(BottomController());

  QRViewController? qrViewController;

  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);
        return bottomController.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Text(
              //   "Scan QR code",
              //   style: TextStyle(fontSize: 20),
              // ),
              Expanded(
                flex: 1,
                child: GetBuilder<ScannerController>(builder: (cont) {
                  return QRView(
                    key: qrKey,
                    onQRViewCreated: (qr) {
                      cont.scanQr(context, qrViewController: qr);
                    },
                    overlay: QrScannerOverlayShape(
                      cutOutSize: MediaQuery.of(context).size.width * 0.8,
                      borderRadius: 10,
                      borderLength: 20,
                      borderWidth: 10,
                      borderColor: MyColors.orange,
                    ),

                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QrCodePage extends StatefulWidget {
  final String? result;
  const QrCodePage({Key? key, this.result}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.result == null
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => CheckInPage());
                    },
                    child: Text("Scan Code"))
                : Text("${widget.result}")
            // TextButton(
            //     onPressed: () {
            //       Get.to(() => QrScanPage());
            //     },
            //     child: Text("scan"))
          ],
        ),
      ),
    ));
  }
}
