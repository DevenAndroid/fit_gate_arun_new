// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/auth/login_screen.dart';
import '../../utils/my_color.dart';
import '../custom_btns/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final bool? isAdmin;
  final VoidCallback? onTap;
  final VoidCallback? cancel;
  final String? label1;
  final String? label2;
  final String? status;
  final String? title;
  final Color? buttonOneColor;
  CustomDialog(
      {Key? key,
      this.isAdmin,
      this.onTap,
      this.label1,
      this.label2,
      this.title,
      this.cancel,
      this.status,
      this.buttonOneColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.all(10),
      backgroundColor: MyColors.white,
      child: SizedBox(
        height: size.height * 0.20,
        width: size.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: MyColors.black),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  CustomButton(
                    onTap: cancel,
                    height: 40,
                    width: 110,
                    title: label2,
                  ),
                  SizedBox(width: 20),
                  CustomButton(
                    onTap: onTap,
                    height: 40,
                    width: 110,
                    title: label1 ?? "Yes",
                    bgColor: buttonOneColor,
                    borderColor: buttonOneColor,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

/*  bool? isLogout = false;
  logOut() async {
    var pref = await SharedPreferences.getInstance();
    if (isLogout = true) {
      await pref.remove("isLogin");
      await pref.remove("isAdminLogin");
      return true;
    } else {
      return false;
    }
  }*/
  // static OverlayEntry overlayLoader(context) {
  //   OverlayEntry loader = OverlayEntry(builder: (context) {
  //     final size = MediaQuery.of(context).size;
  //     return Positioned(
  //       height: size.height,
  //       width: size.width,
  //       top: 0,
  //       left: 0,
  //       child: Material(
  //         color: Colors.black,
  //         child: const CupertinoActivityIndicator(
  //           radius: 30,
  //         ),
  //       ),
  //     );
  //   });
  //   return loader;
  // }
  // static hideShimmer(OverlayEntry loader) {
  //   Timer(const Duration(milliseconds: 500), () {
  //     try {
  //       loader.remove();
  //       // ignore: empty_catches
  //     } catch (e) {}
  //   });
  // }
}


class CustomDialogForUpdate extends StatelessWidget {
  final bool? isAdmin;
  final VoidCallback? onTap;
  final VoidCallback? cancel;
  final String? label1;
  final String? label2;
  final String? status;
  final String? title;
  final Color? buttonOneColor;
  CustomDialogForUpdate(
      {Key? key,
      this.isAdmin,
      this.onTap,
      this.label1,
      this.label2,
      this.title,
      this.cancel,
      this.status,
      this.buttonOneColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.all(10),
      backgroundColor: MyColors.white,
      child: SizedBox(
        height: size.height * 0.20,
        width: size.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: MyColors.black),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: onTap,
                    height: 40,
                    width: 110,
                    title: label1 ?? "Yes",
                    bgColor: buttonOneColor,
                    borderColor: buttonOneColor,
                  ),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

/*  bool? isLogout = false;
  logOut() async {
    var pref = await SharedPreferences.getInstance();
    if (isLogout = true) {
      await pref.remove("isLogin");
      await pref.remove("isAdminLogin");
      return true;
    } else {
      return false;
    }
  }*/
}

// showUpdateDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         print("DIALOGGGGGGGGGGGGGGGGGG      ------------------");
//         return CustomDialogForUpdate(
//           title: "Update is required to use this application",
//           label1: "Update",
//           // label2: "Cancel",
//
//           onTap: () {
//             launchUrl(Uri.parse(Platform.isAndroid
//                 ? "https://play.google.com/store/apps/details?id=com.antigecommerce.fitgate"
//                 : "https://apps.apple.com/bh/app/fitgate/id6444258614"));
//           },
//         );
//       });
// }
