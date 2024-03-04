import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/screens/gym_details_screens/paymnet_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/membership_controller.dart';
import '../../controller/profile_details_controller.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../custom_widgets/custom_btns/size.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../global_functions.dart';
import '../../models/payment_model.dart';
import '../../repo/subscription_list_repo.dart';
// Locale locale = Locale('en','US');

class SingleScreenGym extends StatefulWidget {
  const SingleScreenGym({Key? key, required this.gymId, required this.gymName, required this.index}) : super(key: key);
  final String gymId;
  final String gymName;
  final int index;
  @override
  State<SingleScreenGym> createState() => _SingleScreenGymState();
}

class _SingleScreenGymState extends State<SingleScreenGym> {
  final profileInfoController = Get.put(ProfileDetailscontroller());
  final TextEditingController tipController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final membershipController = Get.put(MembershipController());
   String onFailed = "https://admin.fitgate.live/failed";
   String onSuccess = "https://admin.fitgate.live/failed";
  @override
  void initState() {
    super.initState();
    membershipController.getData(widget.gymId);
    profileInfoController.getProfileDetails(Global.userModel!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    // double finalAmount = double.parse(membershipController.model.value.data![widget.index].price.toString())
    //    +  double.parse(membershipController.model.value.data![widget.index].vat.toString());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:

                  membershipController.model.value.subscriptionBannerImg
                      .toString(),
                  errorWidget: (_, __, ___) =>
                  const SizedBox(),
                  placeholder: (_, __) =>
                  const SizedBox(),
                  fit: BoxFit.cover,
                  height: 200,
                  width: width,
                ),
                Positioned(
                 // top: 70,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          widget.gymName,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
                              ),
                      ),
                    ),),
                Positioned(
                  top: 30,
                  left: 1,
                  //right: 0,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,)),),
              ],
            ),

            // Container(
            //     width: width,
            //     height: 200,
            //     decoration:
            //         BoxDecoration(
            //             image: DecorationImage(
            //                 fit: BoxFit.fill,
            //                 image:
            //                 AssetImage(
            //                     membershipController.model.value.subscriptionBannerImg != null ?
            //                     membershipController.model.value.subscriptionBannerImg.toString():
            //                       "assets/images/wild.png"
            //                 )
            //             )),
            //     child: Center(
            //         child: Text(
            //           widget.gymName,
            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
            //     ))),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      membershipController.model.value.data![widget.index].title.toString(),
                      // textAlign: TextAlign.right,

                      style:
                          GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xff000000)),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 7),
                  //   child: Text(
                  //    "Description",
                  //     // textAlign: TextAlign.right,
                  //
                  //     style:
                  //         GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xff000000)),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        membershipController.model.value.data![widget.index].discription.toString(),
                        //textAlign: TextAlign.right,
                        style:
                            GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12, right: 10, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                // boxShadow: [
                //   BoxShadow(
                //     color: const Color(0xFF37C666).withOpacity(0.10),
                //     offset: const Offset(.1, .1,
                //     ),
                //     blurRadius: 20.0,
                //     spreadRadius: 1.0,
                //   ),
                // ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Summary',
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff000000)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Original Price',
                            style: GoogleFonts.poppins(

                                fontSize: 18, fontWeight: FontWeight.w400, color: const Color(0xff000000)),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                'BD${membershipController.model.value.data![widget.index].previousPrice}',
                                // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                style: GoogleFonts.poppins(
                                  // decorationColor: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff000000)),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Exclusive Price',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400, color: const Color(0xff000000)),
                          ),
                          const Spacer(),
                          Text(
                            'BD${membershipController.model.value.data![widget.index].price}',
                            // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'VAT',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400, color: const Color(0xff000000)),
                          ),
                          const Spacer(),
                          Text(
                            'BD${membershipController.model.value.data![widget.index].vat.toString()}',
                            // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400, color: const Color(0xff000000)),
                          ),
                          const Spacer(),
                          Text(
                            'BD ${double.parse(membershipController.model.value.data![widget.index].price.toString())
                                +  double.parse(membershipController.model.value.data![widget.index].vat.toString())
                            }',

                            // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CommonButton1(
              title: 'Proceed to Payment',
              onPressed: () async {
                // SharedPreferences pref = await SharedPreferences.getInstance();
                // UserModel userModel = UserModel.fromJson(jsonDecode(pref.getString("isLogin")!));
                // cprController.text = userModel.cpr_no.toString();
                // profileInfoController.emailController.text = profileInfoController.model.value.data!.planEmail.toString();
                // profileInfoController.cprController.text = profileInfoController.model.value.data!.cprNo.toString();
                // emailController.text = Global.userModel!.id.toString();
                // print(gymName);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {

                    return Dialog(
                      child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: AddSize.size10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Email ID',
                                          style: GoogleFonts.poppins(
                                              color: Color(0xff000000), fontWeight: FontWeight.w500, fontSize: 15),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons.clear))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RegisterTextFieldWidget(
                                      controller: profileInfoController.emailController,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                            'Please enter your email '),
                                        EmailValidator(errorText: "please enter valid mail")

                                      ]),
                                      hint: "Enter Email ID"),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'CPR Number',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff000000), fontWeight: FontWeight.w500, fontSize: 15),

                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RegisterTextFieldWidget(
                                    //  readOnly: true,
                                      controller: profileInfoController.cprController,
                                      validator: RequiredValidator(errorText: 'Please enter cpr number'),
                                      hint: "Enter CPR Number"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CommonButton1(
                                    title: "Continue",
                                    onPressed: () {

                                      // log(userModel.cpr_no.toString());
                                      if(_formKey.currentState!.validate()){
                                        gymDetailsRepo(
                                          cprNumber: profileInfoController.cprController.text,
                                          planEmail: profileInfoController.emailController.text,
                                          userId: Global.userModel!.id.toString(),
                                        ).then((value) {
                                          if (value.status == true) {
                                            showToast(value.message);
                                            profileInfoController.getProfileDetails(Global.userModel!.id.toString());
                                            givePaymentInfo(
                                              planAmt: membershipController.model.value.data![widget.index].price.toString(),
                                              userId: Global.userModel!.id.toString(),
                                              subscriptionId: membershipController.model.value.data![widget.index].id.toString(),
                                              gymId: widget.gymId,
                                            ).then((value){
                                              // loading(value: true);
                                              // PaymentModel response = PaymentModel.fromJson(jsonDecode(value));
                                              Get.to(()=>PaymentScreen(
                                                paymentUrl: value.result.toString(),
                                              ));

                                            });
                                            // membershipController.getData(Get.arguments[1]);
                                            // Get.back();

                                          } else {
                                            showToast(value.message);
                                          }
                                        });
                                      }
                                      // if(_formKey.currentState!.validate()){
                                      //   givePaymentInfo(
                                      //     planAmt: membershipController.model.value.data![widget.index].price.toString(),
                                      //     userId: Global.userModel!.id.toString(),
                                      //     subscriptionId: membershipController.model.value.data![widget.index].id.toString(),
                                      //     gymId: widget.gymId,
                                      //   ).then((value){
                                      //     // loading(value: true);
                                      //     // PaymentModel response = PaymentModel.fromJson(jsonDecode(value));
                                      //     Get.to(()=>PaymentScreen(
                                      //       paymentUrl: value.result.toString(),
                                      //     ));
                                      //
                                      //   });
                                      // }

                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                );

                // Get.toNamed(CheckoutScreenMart.checkoutScreenOfMart);
              },
            ),
          ],
        ),
      ),
    );
  }
}
