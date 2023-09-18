// ignore_for_file: prefer_const_constructors

import 'package:fit_gate/check_connection.dart';
import 'package:fit_gate/controller/notification_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/bottom_controller.dart';
import '../screens/auth/login_screen.dart';
import '../screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import '../screens/notification_page.dart';
import '../utils/my_images.dart';
import 'custom_btns/custom_button.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? image;
  final String? leadingImage;
  final IconData? actionIcon;
  final VoidCallback? actionIconOnTap;
  final Color? leadingImageClr;
  final Color? imageClr;
  final IconData? iconData;
  final EdgeInsets? padding;
  final String? title;
  final Color? color;
  final Color? iconColor;
  final bool? skipp;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  CustomAppBar(
      {Key? key,
      this.title,
      this.color,
      this.fontWeight,
      this.leadingImage,
      this.onTap,
      this.image,
      this.leadingImageClr,
      this.imageClr,
      this.actionIcon,
      this.actionIconOnTap,
      this.skipp,
      this.iconColor,
      this.iconData,
      this.padding})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(62);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final bottomController = Get.put(BottomController());
  final notificationCon = Get.put(NotificationController());
  bool logout = false;
  countNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await notificationCon.countNotification();
    logout = await pref.getBool('isLogout') ?? false;
    if (mounted) setState(() {});
    print("logouttttttttt  $logout -- $isArrowShow");
  }

  @override
  void initState() {
    countNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(62),
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            child: CheckConnection(), preferredSize: Size.fromHeight(70)),
        title: Text(
          "${widget.title}",
          style: TextStyle(color: widget.color ?? MyColors.black),
        ),
        leading: GestureDetector(
            onTap: widget.onTap ??
                () {
                  print("object");
                  bottomController.setSelectedScreen(false,
                      screenName: BottomNavigationScreen());
                  // Get.to(() => BottomNavigationScreen());
                  // context.go('/page2');
                },
            child: widget.leadingImage != null
                ? SizedBox()
                : logout == true && isArrowShow == true
                    ? SizedBox()
                    : GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, top: 18, bottom: 11, right: 18),
                            child: Image.asset(
                              widget.leadingImage ?? MyImages.arrowBack,
                              color: widget.leadingImageClr ?? MyColors.black,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          /*ImageButton(
                        padding: EdgeInsets.only(
                            left: 20, top: 18, bottom: 11, right: 17),
                        image: widget.leadingImage ?? MyImages.arrowBack,
                        height: 20,
                        width: 20,
                        color: widget.leadingImageClr ?? MyColors.black,
                      ),*/
                        ),
                      )),
        actions: [
          widget.image != null
              ? SizedBox()
              : Global.userModel?.phoneNumber == null
                  ? SizedBox()
                  : GetBuilder<NotificationController>(builder: (cont) {
                      return GestureDetector(
                        onTap: () async {
                          Get.to(() => NotificationPage());
                          print(
                              "Notification TAPPPPP ----------------- ++++++++++++++   ${notificationCon.notifyCount}  ");
                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  widget.iconData ?? Icons.notifications_none,
                                  size: 25,
                                  color: widget.iconColor ?? MyColors.black,
                                ),
                              ),
                              notificationCon.notifyCount == true
                                  ? Positioned(
                                      right: 10,
                                      // top: 3,
                                      child: Container(
                                        height: 8,
                                        width: 9,
                                        decoration: BoxDecoration(
                                          color: MyColors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      );
                    }),
          // IconButton(
          //     onPressed: () async {
          //       log("Firebase token....    ${await FirebaseMessaging.instance.getToken()}");
          //       NotificationService()
          //           .showSimpleNotification(title: "dsaadad", body: "sadsdad");
          //     },
          //     icon: Icon(
          //       Icons.error_outline_rounded,
          //       color: Colors.red,
          //     )),
          // ImageButton(
          //             onTap: () {
          //               Get.to(() => NotificationPage());
          //             },
          //             image: MyImages.notification,
          //             color: imageClr ?? MyColors.black,
          //             padding: EdgeInsets.all(18),
          //           ),

          widget.actionIcon == null
              ? SizedBox()
              : GestureDetector(
                  onTap: widget.actionIconOnTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      widget.actionIcon,
                      color: MyColors.black,
                      size: 26,
                    ),
                  ),
                ),
          widget.skipp == true
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CustomButton(
                      onTap: () async {
                        var pref = await SharedPreferences.getInstance();
                        await pref.setBool('isSkip', true);
                        print(
                            "PREFFFFF   +----+----+-----+------+    ----+ ----+ ${await pref.setBool('isSkip', true)}");

                        print("PHONE NO>:${Global.userModel?.phoneNumber}");
                        push(
                            context: context,
                            screen: BottomNavigationScreen(),
                            pushUntil: true);
                        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => BottomNavigationScreen()), (route) => false);
                      },
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.18,
                      borderRadius: BorderRadius.circular(5),
                      bgColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      fontColor: MyColors.orange,
                      title: "Skip",
                      fontSize: 16.5,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

/*position: BadgePosition.topEnd(top: 15, end: 0),
                          // showBadge:
                          //     notificationCon.notifyCount == 0 ? false : true,
                          padding: widget.padding ?? EdgeInsets.all(0),*/
