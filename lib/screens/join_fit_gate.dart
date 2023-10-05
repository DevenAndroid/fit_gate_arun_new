// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fit_gate/controller/get_company_controller.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_join_fit_card.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/auth/sign_up_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_btns/custom_button.dart';

class JoinFitGatePage extends StatefulWidget {
  String? userType;
  String? id;
  JoinFitGatePage({
    Key? key,
    this.userType,
    this.id,
  }) : super(key: key);

  @override
  State<JoinFitGatePage> createState() => _JoinFitGatePageState();
}

class _JoinFitGatePageState extends State<JoinFitGatePage> {
  int? joinUser;
  int? chooseOption;
  var dropdownValue;
  var id;

  final getCompanyController = Get.put(BannerController());

  getCompany() async {
    await getCompanyController.getCompany();
  }

  // Future<bool> _onWillPop() async {
  //   bool? exitResult = await showDialog<bool>(
  //       context: context,
  //       builder: (_) => CustomDialog(
  //             title: "Do you really want to exit",
  //             label1: "Yes",
  //             label2: "No",
  //             cancel: () {
  //               Navigator.pop(context, false);
  //             },
  //             onTap: () {
  //               exit(0);
  //             },
  //           ));
  //   return exitResult ?? false;
  // }

  @override
  void initState() {
    getCompany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Get.back();
        },
        skipp: true,
        title: "Join fit gate",
        image: "",
        leadingImage: "",
        fontWeight: FontWeight.w900,
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomJoinFitCard(
                    isJoinFitGate: true,
                    onClick: () {
                      joinUser = 1;
                      widget.userType = 'citizen';
                      setState(() {});
                    },
                    selectedIndex: joinUser,
                    index: 1,
                    fontSize: 20,
                    title: "Apply as a normal citizen",
                    img: MyImages.citizen,
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  CustomJoinFitCard(
                    isJoinFitGate: true,
                    onClick: () {
                      joinUser = 2;
                      widget.userType = 'employee';
                      setState(() {});
                      // Get.to(() => LoginScreen());
                    },
                    // color: MyColors.grey.withOpacity(.30),
                    selectedIndex: joinUser,
                    index: 2,
                    title: "Apply as an employee",
                    fontSize: 20,
                    img: MyImages.emp,
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Select your company",
                    style: TextStyle(
                      color: MyColors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  // joinUser == 1
                  //     ? Container(
                  //         height: 20,
                  //         // width: 50,
                  //         decoration: BoxDecoration(
                  //           color: MyColors.grey.withOpacity(.30),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Select Company",
                  //         style: TextStyle(
                  //             color: MyColors.black, fontSize: 16),
                  //       ),
                  //       icon: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         color: MyColors.grey,
                  //       ),
                  //
                  //     ],
                  //   ),
                  //       )
                  //     :
                  GetBuilder<BannerController>(builder: (controller) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: joinUser == 1 ? MyColors.grey.withOpacity(.30) : MyColors.white,
                        border: Border.all(color: MyColors.grey.withOpacity(0.20)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: joinUser == 1
                                ? []
                                : controller.getCompanyList.isEmpty
                                    ? ['No company Found'].map((e) => DropdownMenuItem(child: Text('$e'))).toList()
                                    : controller.getCompanyList
                                        .map((items) => DropdownMenuItem(
                                              value: "${items.id}",
                                              child: Text(items.name.toString()),
                                            ))
                                        .toList(),
                            onChanged: (newVal) {
                              setState(() {
                                dropdownValue = newVal;
                                print("$dropdownValue");
                              });
                            },
                            value: dropdownValue,
                            hint: Text(
                              "Select Company",
                              style: TextStyle(color: MyColors.black, fontSize: 16),
                            ),
                            style: TextStyle(
                              color: MyColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                            dropdownColor: MyColors.white,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: MyColors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
              onTap: () {
                if (widget.userType == null) {
                  return showToast("Please choose type before register");
                } else if (widget.userType == 'employee' && dropdownValue == null) {
                  return showToast("Please choose company name before register");
                } else {
                  Get.to(() => SignUpScreen(
                        userType: widget.userType,
                        id: dropdownValue.toString(),
                      ));
                }
              },
              height: MediaQuery.of(context).size.height * 0.06,
              title: "Join Now",
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
