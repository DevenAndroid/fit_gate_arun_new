// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/check_out_page.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/subscription_controller.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_btns/custom_button.dart';
import '../custom_widgets/custom_cards/custom_subscriptions_card.dart';
import '../global_functions.dart';
import '../utils/my_color.dart';
import 'bottom_bar_screens/home_page.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedIndex = 0;
  // int packageIndex = 0;
  final bottomController = Get.put(BottomController());
  final auth = Get.put(LoginController());
  final subscriptionController = Get.put(SubscriptionController());
  List<GymPackage> gymPackage = [
    GymPackage(Colors.indigo.shade400, "Sapphire", "29.99", "Total of 3 gyms",
        MyColors.lightIndigo, MyImages.sapphire),
    GymPackage(Colors.green, "Emerald", "39.99", "Total of 5 gyms",
        MyColors.lightGreen, MyImages.emerald),
    GymPackage(Colors.red.shade400, "Ruby", "49.99", "Total of 7 gyms",
        MyColors.lightRed, MyImages.ruby),
  ];
  getSubscriptionList() async {
    await auth.getUserById();
    await subscriptionController.activeSubscriptionPlan();
  }

  @override
  void initState() {
    getSubscriptionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);
        return bottomController.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Subscription",
          fontWeight: FontWeight.w900,
        ),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: GetBuilder<SubscriptionController>(builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benefits",
                    style: TextStyle(
                      color: MyColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  // SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomRowText(
                            title: "Monthly subscription (Auto-renewal)",
                          ),
                          CustomRowText(
                            title: "Visit any gym,any day",
                          ),
                          CustomRowText(
                            title: "Cancel anytime",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Packages",
                    style: TextStyle(
                      color: MyColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<SubscriptionController>(
                        builder: (controller) {
                      return ListView.builder(
                          itemCount: controller.subscriptionList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = controller.subscriptionList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 13.0, bottom: 4),
                              child: CustomSubscriptionCard(
                                onClick: () {
                                  selectedIndex = index;
                                  setState(() {});
                                  print(
                                      '${subscriptionController.subscriptionList[selectedIndex].id.toString()}');
                                },
                                model: data,
                                index: index,
                                selectedIndex: selectedIndex,
                                gymPackage: gymPackage[index],
                              ),
                            );
                          });
                    }),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomButton(
                      onTap: () async {
                        if (subscriptionController
                                    .subscriptionList[selectedIndex].id ==
                                Global.activeSubscriptionModel
                                    ?.subscriptionPackageId &&
                            Global.activeSubscriptionModel?.status ==
                                'ACTIVE') {
                          snackBar("This plan is already activated");
                        } else if (Global.userModel?.subscriptionStatus == "" ||
                            Global.userModel?.subscriptionStatus ==
                                "CANCELLED") {
                          bottomController.setSelectedScreen(true,
                              screenName: CheckOutPage(
                                id: subscriptionController
                                    .subscriptionList[selectedIndex].id
                                    .toString(),
                              ));
                          print(
                              'SUBSSS IDDD ------------      ${subscriptionController.subscriptionList[selectedIndex].id.toString()}');
                          Get.to(() => BottomNavigationScreen());
                        } else {
                          await subscriptionController.updateSubscription(
                              id: subscriptionController
                                  .subscriptionList[selectedIndex].id,
                              subId: Global
                                  .activeSubscriptionModel?.subscriptionId);
                          setState(() {});
                          print(
                              'PACKAGE ---- ${Global.activeSubscriptionModel?.subscriptionPackageId}');
                          bottomController.setSelectedScreen(true,
                              screenName: AccountScreen());
                          bottomController.getIndex(3);
                          Get.to(() => BottomNavigationScreen());
                        }

                        //  CheckOutPage(
                        //                             gymPackage: gymPackage[selectedIndex])
                      },
                      height: MediaQuery.of(context).size.height * 0.06,
                      title: "Continue",
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomRowText extends StatelessWidget {
  final String? title;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? color;
  final Color? checkColor;
  const CustomRowText(
      {Key? key,
      this.title,
      this.borderRadius,
      this.color,
      this.border,
      this.checkColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: color ?? MyColors.orange,
              borderRadius: borderRadius ?? BorderRadius.circular(30),
              border: border
              // shape: shape ?? BoxShape.circle,
              ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              Icons.check,
              size: 12,
              color: checkColor ?? MyColors.white,
            ),
          ),
        ),
        SizedBox(width: 9),
        Expanded(
          child: Text(
            "$title",
            style: TextStyle(
              color: MyColors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
