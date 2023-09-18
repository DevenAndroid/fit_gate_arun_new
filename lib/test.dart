import 'package:fit_gate/custom_widgets/custom_app_bar.dart';
import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_account_card.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_join_fit_card.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';

import 'utils/my_images.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int chooseOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: CustomAppBar(
            title: "Subscription",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Subscription",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
              SizedBox(height: 30),
              Text(
                "Packages",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              CustomAccountCard(
                onClick: () {},
                // expiryDate: Global.userModel?.subscriptionTo,
                title: "Pro - Bahrain",
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ImageButton(
                    padding: EdgeInsets.zero,
                    image: MyImages.diamond,
                    // width: 29,
                    // height: 29,
                    // height: 100,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    // height: MediaQuery.of(context).size.height * 4,
                    // color: MyColors.orange,
                    // size: iconSize ?? 50,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Payment Options",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomJoinFitCard(
                      onClick: () {
                        chooseOption = 1;
                        setState(() {});
                      },
                      selectedIndex: chooseOption,
                      index: 1,
                      iconSize: 17,
                      boxShadow: BoxShadow(
                        color: chooseOption == 1
                            ? MyColors.orange.withOpacity(.10)
                            : MyColors.grey.withOpacity(0.15),
                        spreadRadius: 7,
                        blurRadius: 20,
                      ),
                      height: MediaQuery.of(context).size.height * 0.086,
                      title: "2 BHD / month",
                      borderRadius: BorderRadius.circular(10),
                      // img: MyImages.activity,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomJoinFitCard(
                      onClick: () {
                        chooseOption = 2;
                        setState(() {});
                      },
                      selectedIndex: chooseOption,
                      index: 2,
                      boxShadow: BoxShadow(
                        color: chooseOption == 2
                            ? MyColors.orange.withOpacity(.10)
                            : MyColors.grey.withOpacity(0.15),
                        spreadRadius: 7,
                        blurRadius: 20,
                      ),
                      iconSize: 17,
                      height: MediaQuery.of(context).size.height * 0.086,
                      title: "15BHD / year",
                      iconClr: MyColors.grey,
                      isOffer: true,
                      borderRadius: BorderRadius.circular(10),
                      // img: MyImages.setting,
                    ),
                  ),
                ],
              ),
              // Spacer(),
              SizedBox(height: 130),
              CustomButton(
                height: MediaQuery.of(context).size.height * 0.065,
                title: "Proceed to Payment",
              )
            ],
          ),
        ),
      ),
    );
  }
}
