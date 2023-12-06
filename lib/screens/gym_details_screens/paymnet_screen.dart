import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../custom_widgets/custom_btns/size.dart';
import '../../global_functions.dart';
import '../bottom_bar_screens/bottom_naviagtion_screen.dart';
import '../bottom_bar_screens/home_page.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentUrl, this.onSuccess, this.onFailed});
  final String paymentUrl;
  final Function()? onSuccess;
  final Function()? onFailed;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? controller;
  bool webLoaded = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      log("Received Url......     ${widget.paymentUrl}");
      controller = WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              log("Navigation Request....      ${request.url}");
              if (request.url.contains("https://admin.fitgate.live/success")) {
                showToast("Payment Successfully".tr);
                Get.to(() => const BottomNavigationScreen());
                // if(widget.onSuccess == "success") {
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //    Get.to(() => const BottomNavigationScreen());
                // } else {
                //   widget.onSuccess!();
                // }
                return NavigationDecision.prevent;
              }
              if (request.url.contains("https://admin.fitgate.live/failed")) {
                // showToast("Payment Failed".tr);
                Get.back();
                Get.back();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
      controller!.loadRequest(Uri.parse(widget.paymentUrl)).then((value) {
        webLoaded = true;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.clearCache();
    controller!.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller!.canGoBack()) {
          controller!.goBack();
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
       appBar: AppBar(
         toolbarHeight: 60,
         elevation: 0,
         leadingWidth: AddSize.size20 * 2.2,
         backgroundColor: Colors.transparent,
         title: Text(
           "Payment",
           style: GoogleFonts.quicksand(
             fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xff303D48),),
         ),
         leading: Padding(
           padding: EdgeInsets.only(left: AddSize.padding20),
           child: GestureDetector(
               onTap: () {
                 Get.back();
                 if (dispose == "dispose") {}
               },
               child:
                   Image.asset(
                     "assets/images/backArrow.png",
                     height: AddSize.size25,
                   )),
         ),
       ),
        body: webLoaded
            ? WebViewWidget(
          controller: controller!,
        )
            : Center(child: const Text("Please try again later")),
      ),
    );
  }
}
