// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  CustomDialog(
      {Key? key,
      this.isAdmin,
      this.onTap,
      this.label1,
      this.label2,
      this.title,
      this.cancel,
      this.status})
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
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: MyColors.black),
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
}
