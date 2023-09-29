// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_gate/custom_widgets/custom_app_bar.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/auth/verify_phone_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../controller/auth_controllers/login_controller.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../global_functions.dart';
import '../../utils/my_images.dart';

class SignUpScreen extends StatefulWidget {
  final String? userType;
  final String? id;
  final String? dialCode;
  const SignUpScreen({Key? key, this.userType, this.id, this.dialCode}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColors.grey,
      ),
      borderRadius: BorderRadius.circular(10));
  String isoCode = 'BH';
  bool isValid = false;
  String? verificationCode = "";
  String? dialCode;
  TextEditingController phone = TextEditingController();
  final auth = FirebaseAuth.instance;
  final loginController = Get.put(LoginController());
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      EasyLoading.showToast("Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        snackbarKey.currentState?.hideCurrentSnackBar();
        phone.clear();
        // onWillPop();
        return await true;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              title: "",
              image: "",
              // skipp: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ImageButton(
                              image: MyImages.logo,
                              width: MediaQuery.of(context).size.width * 0.63,
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Create Account",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Please create an account to continue...",
                            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500, color: MyColors.grey),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Phone number",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) async {
                              print(number);
                              setState(() {
                                isoCode = number.isoCode!;
                                dialCode = number.dialCode!;
                              });
                            },
                            onInputValidated: (val) {
                              if (val == true) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                              setState(() {
                                isValid = val;
                              });
                              print("VAL  ::: $val");
                              print("ISVALID ::: $isValid");
                            },
                            errorMessage: "",
                            // suffixIcon: isValid
                            //     ? SizedBox()
                            //     : ImageButton(
                            //   image: MyImages.cancel,
                            //   width: 10,
                            //   height: 10,
                            //   padding: EdgeInsets.all(14),
                            // ),
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              leadingPadding: 5,
                              trailingSpace: false,
                              setSelectorButtonAsPrefixIcon: true,
                            ),
                            keyboardType: Platform.isIOS
                                ? TextInputType.numberWithOptions(signed: true, decimal: true)
                                : TextInputType.number,
                            ignoreBlank: false,
                            formatInput: false,
                            initialValue: PhoneNumber(isoCode: isoCode),
                            textFieldController: phone,
                            inputDecoration: InputDecoration(
                              suffixIcon: isValid
                                  ? Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: MyColors.green,
                                      size: 24,
                                    )
                                  : ImageButton(
                                      image: MyImages.cancel,
                                      width: 10,
                                      height: 10,
                                      padding: EdgeInsets.all(14),
                                    ),
                              isDense: true,
                              fillColor: MyColors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              hintText: "",
                              hintStyle: TextStyle(fontSize: 13),
                              border: border,
                              enabledBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              focusedBorder: border,
                            ),
                            cursorColor: MyColors.black,
                          ),
                          // Spacer(),
                          SizedBox(height: 50),
                          CustomButton(
                            onTap: () async {
                              print('$dialCode ${phone.text}');
                              print(dialCode);
                              if (phone.text.isNotEmpty) {
                                if (isValid == true) {
                                  var phoneValid = await loginController.checkPhoneNo(phoneNo: phone.text);
                                  if (phoneValid == true) {
                                    try {
                                      print("TRYYYYY ");
                                      loading(value: true);
                                      await auth.verifyPhoneNumber(
                                        phoneNumber: "$dialCode${phone.text}",
                                        verificationCompleted: (PhoneAuthCredential credential) async {
                                          print("VERIFICATION COMPLETED");
                                        },
                                        verificationFailed: (FirebaseAuthException e) {
                                          loading(value: false);
                                          print("FAILEDDDDD");
                                          print("ERORRRRR $e");
                                          snackBar("Something went wrong");
                                        },
                                        codeSent: (String? verificationID, int? resendToken) {
                                          print("CODE SENT");
                                          print("DIAL  CODE$dialCode");
                                          loading(value: false);
                                          Get.to(() => VerifyPhoneScreen(
                                                verificationId: verificationID,
                                                phone: phone.text,
                                                dialCode: dialCode,
                                                userType: "citizen",
                                                id: widget.id,
                                              ));
                                          print("CPMAPNY ID -----  ${widget.id}");
                                        },
                                        codeAutoRetrievalTimeout: (String? verificationId) {
                                          verificationCode = verificationId;
                                          print("TIME OUT");
                                          // print("VERIFICATION ID${verificationId}");
                                        },
                                        timeout: Duration(minutes: 1),
                                      );
                                    } catch (e) {
                                      print("ERRORRRRRRR $e");
                                      snackBar("Something went wrong");
                                    }
                                  }
                                  // else {
                                  //   return snackBar(
                                  //       "You already have an account please sign in instead");
                                  // }
                                } else {
                                  print("INVALID NUMBER ");
                                  return snackBar("Please enter valid number");
                                }
                              } else {
                                return snackBar("Please enter number");
                              }
                            },
                            height: MediaQuery.of(context).size.height * 0.06,
                            title: "SEND OTP",
                            fontSize: 16,
                          ),
                          SizedBox(height: 30),
                          // Align(
                          //   alignment: Alignment.topCenter,
                          //   child: Text(
                          //     "Terms of Service and Privacy Policy",
                          //     style: TextStyle(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w600,
                          //         color: MyColors.orange),
                          //   ),
                          // ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: MyColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    snackbarKey.currentState?.hideCurrentSnackBar();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                    // Get.to(LoginScreen());
                                    // push(context: context, screen: LoginScreen());
                                  },
                                  child: Text(
                                    "Please sign in instead",
                                    style: TextStyle(color: MyColors.orange, fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

/*CustomButton(
                  onTap: () async {},
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.18,
                  borderRadius: BorderRadius.circular(20),
                  title: "Skip",
                  fontSize: 15,
                ),


                CustomUnderlineTxt(
                    title: "Skip",
                    size: 18,
                    fontWeight: FontWeight.normal,
                    onTap: () {
                      Get.to(() => BottomNavigationScreen());
                    },
                  ),
                */
