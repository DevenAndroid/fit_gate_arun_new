// ignore_for_file: prefer_const_constructors

import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/controller/notification_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/custom_widgets/dialog/custom_dialog.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/home_page.dart';
import 'package:fit_gate/screens/check_in_page.dart';
import 'package:fit_gate/screens/explore.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controller/bottom_controller.dart';
import '../../utils/my_color.dart';
import '../auth/login_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final indexCon = Get.put(BottomController());
  final loginController = Get.put(LoginController());
  final notifyController = Get.put(NotificationController());
  final mapController = Get.put(MapController());

  List<Widget> myPages = [
    HomePage(),
    Explore(),
    CheckInPage(),
    AccountScreen(),
  ];
  getNotify() async {

    await mapController.getCurrentLocation();
    await notifyController.notification();
    await loginController.getUserById();
  }

  @override
  void initState() {
    getNotify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomController>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.081,
          color: MyColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: customBottomText(
                  MyImages.home,
                  controller.currentIndex,
                  "Home",
                  0,
                  onTap: () {
                    controller.setSelectedScreen(false);
                    controller.getIndex(0);
                  },
                ),
              ),
              Expanded(
                child: customBottomText(
                  MyImages.explore,
                  controller.currentIndex,
                  "Explore",
                  1,
                  onTap: () {
                    controller.setSelectedScreen(false);
                    controller.getIndex(1);
                  },
                ),
              ),
              Expanded(
                child: customBottomText(
                  MyImages.checkIn,
                  controller.currentIndex,
                  "Check In",
                  2,
                  onTap: () async {
                    await loginController.getUserById();
                    controller.setSelectedScreen(false);
                    indexCon.getIndex(Global.userModel?.phoneNumber == null ? 0 : 2);
                    Global.userModel?.phoneNumber == null ? showToast("You need to login to access this page") : null;
                    // controller.getIndex(
                    //     Global.userModel?.subscriptionStatus == "ACTIVE"
                    //         ? 2
                    //         : 0);
                    // Global.userModel?.subscriptionStatus == "ACTIVE"
                    //     ? null
                    //     : snackBar(
                    //         "You need to have an active subscription plan to check-in");
                  },
                ),
              ),
              Expanded(
                child: customBottomText(
                  MyImages.account,
                  controller.currentIndex,
                  "Account",
                  3,
                  onTap: () {
                    controller.setSelectedScreen(false);
                    indexCon.getIndex(Global.userModel?.phoneNumber == null ? 0 : 3);
                    Global.userModel?.phoneNumber == null
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              print("DIALOGGGGGGGGGGGGGGGGGG      ------------------");
                              return CustomDialog(
                                title: "You need to login to access this page",
                                label1: "Login",
                                label2: "Cancel",
                                onTap: () {
                                  Get.off(() => LoginScreen());
                                },
                                cancel: () {
                                  Get.back();
                                },
                              );
                            })
                        : null;
                  },
                ),
              ),
            ],
          ),
        ),
        body: controller.selectScreen ? controller.screenNameVal : myPages[controller.currentIndex],
        //  body: ActivityLogsScreen(),
      ),
    );
  }

  Padding customBottomText(icon, index, title, selectedIndex, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: MyColors.white,
          child: Column(
            children: [
              ImageButton(
                padding: EdgeInsets.zero,
                image: icon,
                height: 20, width: 20,
                // MyImages.add,
                // height: 22,
                color: index == selectedIndex ? MyColors.orange : MyColors.grey.withOpacity(.70),
              ),
              SizedBox(height: 3),
              Text(
                "$title",
                style: TextStyle(color: index == selectedIndex ? MyColors.orange : MyColors.grey.withOpacity(.70)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
