import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/subscription_controller.dart';
import '../../global_functions.dart';
import '../../utils/my_color.dart';
import '../dialog/custom_dialog.dart';

class CustomAccountCard extends StatelessWidget {
  final String? title;
  final String? expiryDate;
  final String? img;
  final String? bgImg;
  final double? height;
  final double? iconSize;
  final VoidCallback? onClick;
  final Widget child;
  CustomAccountCard({
    Key? key,
    this.title,
    this.img,
    this.height,
    this.iconSize,
    this.onClick,
    this.bgImg,
    required this.child,
    this.expiryDate,
  }) : super(key: key);

  getDate(_date) {
    var inputFormat = DateFormat('yy-MM-dd');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  final subscriptionController = Get.put(SubscriptionController());
  final bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.12,
        // width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgImg ?? MyImages.proBg), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: child,
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    expiryDate == null ? SizedBox(height: 27) : Spacer(),
                    Text(
                      "$title",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        expiryDate == null
                            ? SizedBox()
                            : Text(
                                "Expire on : ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        Text(
                          expiryDate == null
                              ? ""
                              : getDate(expiryDate!.substring(0, 11)),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    expiryDate == null ? SizedBox() : Spacer()
                  ],
                ),
              ),
              expiryDate == null
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () async {
                        if (Global.activeSubscriptionModel?.status ==
                            "ACTIVE") {
                          showDialog(
                              context: context,
                              builder: (_) => CustomDialog(
                                    title:
                                        "Are sure you want to delete subscription?",
                                    label1: "Yes",
                                    label2: "No",
                                    cancel: () {
                                      Get.back();
                                    },
                                    onTap: () async {
                                      loading(value: true);
                                      await subscriptionController
                                          .deleteSubscriptionPlan(Global
                                              .activeSubscriptionModel
                                              ?.subscriptionId);
                                      print(Global.activeSubscriptionModel
                                          ?.subscriptionId);
                                      await subscriptionController
                                          .activeSubscriptionPlan();
                                      Global.activeSubscriptionModel = null;
                                      loading(value: false);
                                      bottomController.setSelectedScreen(true,
                                          screenName: AccountScreen());
                                      Get.back();
                                    },
                                  ));
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.delete_outline,
                                size: 20, color: Colors.red.shade700),
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
