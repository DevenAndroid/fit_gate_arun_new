// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/image_controller.dart';
import 'package:fit_gate/controller/subscription_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_account_card.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/activity_log_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/home_page.dart';
import 'package:fit_gate/screens/setting_screen.dart';
import 'package:fit_gate/test.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/bottom_controller.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_cards/custom_join_fit_card.dart';
import '../../custom_widgets/custom_circle_avatar.dart';
import '../../utils/my_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final indexCon = Get.put(BottomController());
  var imgController = Get.put(ImageController());
  var loginController = Get.put(LoginController());
  final activeSubsCon = Get.put(SubscriptionController());
  int chooseOption = 0;
  var data = Global.userModel;
  getData() async {
    // loading(value: true);
    await loginController.getUserById();
    await activeSubsCon.activeSubscriptionPlan();
    // loading(value: false);
    if (mounted) setState(() {});
    if (data != null) {
      imgController.imgUrl = Global.userModel?.avatar;
      // setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        indexCon.getIndex(0);
        return indexCon.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: "Account",
            leadingImage: "",
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 14),
            child: GetBuilder<BottomController>(
                builder: (controller) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("------------- URl ====== ${imgController.imgUrl}");
                                },
                                child: imgController.imgUrl == null && Global.userModel?.avatar == null
                                    ? CustomCircleAvatar(image: AssetImage("assets/images/1.png"))
                                    : CachedNetworkImage(
                                        imageBuilder: (context, imageProvider) => CircleAvatar(
                                          radius: 45,
                                          backgroundImage: imageProvider,
                                        ),
                                        placeholder: (c, url) => CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 45,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              color: MyColors.orange,
                                            ),
                                          ),
                                        ),
                                        imageUrl: "${Global.userModel!.avatar.toString()}",
                                        errorWidget: (c, u, r) => Container(),
                                      ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Global.userModel?.name ?? "Username",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Global.activeSubscriptionModel?.status == 'ACTIVE'
                        //     ?
                        Text(
                          "Subscription Plan ",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        // : SizedBox(),
                        SizedBox(height: 15),
                        // Global.activeSubscriptionModel?.status == 'ACTIVE'
                        //    ?

                        // GetBuilder<BottomController>(builder: (controller) {
                        //   return CustomAccountCard(
                        //     onClick: () {
                        //       // controller.getIndex(1);
                        //       // controller.setSelectedScreen(true,
                        //       //     screenName: Subscription());
                        //     },
                        //     // expiryDate: Global.userModel?.subscriptionTo,
                        //     title: "Free",
                        //     child: Container(
                        //       width: MediaQuery.of(context).size.width * 0.1,
                        //       height: MediaQuery.of(context).size.height * 0.08,
                        //       padding: EdgeInsets.all(9),
                        //       decoration: BoxDecoration(
                        //         color: MyColors.white,
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: ImageButton(
                        //         padding: EdgeInsets.zero,
                        //         image: MyImages.diamond,
                        //         // width: 29,
                        //         // height: 29,
                        //         // height: 100,
                        //         // width: MediaQuery.of(context).size.width * 0.9,
                        //         // height: MediaQuery.of(context).size.height * 4,
                        //         // color: MyColors.orange,
                        //         // size: iconSize ?? 50,
                        //       ),
                        //     ),
                        //   );
                        // }),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Free",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: MyColors.orange,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Enjoy free offers",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // : SizedBox(),
                        SizedBox(height: 15),
                        Text(
                          "Other Option",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: CustomJoinFitCard(
                                onClick: () {
                                  // if (Global.activeSubscriptionModel?.status ==
                                  //     "ACTIVE") {
                                  chooseOption = 1;
                                  setState(() {});
                                  controller.setSelectedScreen(true, screenName: ActivityLogsScreen());
                                  Get.to(() => BottomNavigationScreen());

                                  // } else {
                                  //   snackBar("Purchase subscription plan first",
                                  //       color: MyColors.black.withOpacity(.80));
                                  // }
                                },
                                selectedIndex: chooseOption,
                                index: 1,
                                iconSize: 17,
                                boxShadow: BoxShadow(
                                  color: MyColors.grey.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 24,
                                ),
                                height: MediaQuery.of(context).size.height * 0.06,
                                title: "Activities",
                                borderRadius: BorderRadius.circular(10),
                                img: MyImages.activity,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: CustomJoinFitCard(
                                onClick: () {
                                  chooseOption = 2;
                                  setState(() {});
                                  controller.setSelectedScreen(true, screenName: SettingScreen());
                                  Get.to(() => BottomNavigationScreen());
                                },
                                selectedIndex: chooseOption,
                                index: 2,
                                boxShadow: BoxShadow(
                                  color: MyColors.grey.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 24,
                                ),
                                iconSize: 17,
                                height: MediaQuery.of(context).size.height * 0.06,
                                title: "Settings",
                                iconClr: MyColors.grey,
                                borderRadius: BorderRadius.circular(10),
                                img: MyImages.setting,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    )),
          ))),
    );
  }
}
