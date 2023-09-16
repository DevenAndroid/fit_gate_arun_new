import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_subscriptions_card.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/subscription_controller.dart';
import '../../models/subscription_list_model.dart';
import '../../utils/my_color.dart';

class CustomSubscriptionPlanCard extends StatelessWidget {
  final String? title;
  final String title11;
  final String? title1;
  final String? title2;
  final String? image;
  final String bgImage;
  final String? img;
  final Color? cardClr;
  final Color? borderClr;
  final double? height;
  final double? iconSize;
  final int? index;
  final int? selectedIndex;
  final VoidCallback? onClick;
  final GymPackage? gymPackage;
  final SubscriptionListModel? model;
  CustomSubscriptionPlanCard(
      {Key? key,
      this.title,
      this.img,
      this.height,
      this.iconSize,
      this.image,
      this.index,
      this.selectedIndex,
      this.onClick,
      this.title1,
      this.title2,
      this.cardClr,
      this.borderClr,
      required this.bgImage,
      this.gymPackage,
      this.model, required this.title11})
      : super(key: key);
  final subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    // print("PACKAGEEEEEEEEE  ========================   ${title}");
    // print(
    //     "subscriptionType ========================  ${Global.userModel?.subscriptionPlan}");
    return GestureDetector(
      onTap: onClick,
      child: Container(
        // padding: EdgeInsets.only(top: 20, bottom: 20),
        height: height ?? MediaQuery.of(context).size.height * 0.12,
        // width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: cardClr,
          image: DecorationImage(
              image: AssetImage(model?.planName == 'sapphire'
                  ? MyImages.sapphireBg
                  : model?.planName == 'emerald'
                      ? MyImages.emeraldBg
                      : MyImages.rubyBg),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: index == selectedIndex ? borderClr! : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ImageButton(
                  padding: EdgeInsets.zero,
                  image: model?.planName == 'sapphire'
                      ? MyImages.sapphire
                      : model?.planName == 'emerald'
                          ? MyImages.emerald
                          : MyImages.ruby,
                  // width: 29,
                  // height: 29,
                  // height: 100,
                  // width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 4,
                  // color: MyColors.orange,
                  // size: iconSize ?? 50,
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${title![0].toUpperCase()}${title!.substring(1)}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    // Spacer(),
                    // Text(
                    //   "BD${model?.amount} ${model?.intervalType}",
                    //   style: TextStyle(
                    //     color: MyColors.white,
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // Spacer(),
                    Text(
                      title11,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: onClick,
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.033,
                    title: Global.activeSubscriptionModel?.status == "ACTIVE" &&
                            (title == Global.activeSubscriptionModel?.planName)
                        ? "Active"
                        : Global.activeSubscriptionModel?.status == "ACTIVE"
                            ? "Upgrade"
                            : "Join",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    borderColor: Colors.transparent,
                    fontColor: MyColors.black,
                    bgColor: MyColors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  */ /*Global.activeSubscriptionModel?.status == "ACTIVE" &&
                          (title == Global.activeSubscriptionModel?.planName)
                      ? Spacer()
                      : SizedBox(),
                  Global.activeSubscriptionModel?.status == "ACTIVE" &&
                          (title == Global.activeSubscriptionModel?.planName)
                      ? CustomButton(
                          onTap: onClick,
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.033,
                          title: "delete",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          borderColor: Colors.transparent,
                          fontColor: index == selectedIndex
                              ? MyColors.orange
                              : MyColors.black,
                          bgColor: MyColors.white,
                          borderRadius: BorderRadius.circular(5),
                        )
                      : SizedBox(),*/ /*
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
