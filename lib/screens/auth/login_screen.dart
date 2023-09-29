// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit_gate/custom_widgets/custom_app_bar.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/auth/sign_up_screen.dart';
import 'package:fit_gate/screens/auth/verify_phone_screen.dart';
import 'package:fit_gate/screens/inro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/auth_controllers/login_controller.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../custom_widgets/custom_btns/icon_button.dart';
import '../../utils/my_color.dart';
import '../../utils/my_images.dart';

bool isArrowShow = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColors.grey,
      ),
      borderRadius: BorderRadius.circular(10));
  String isoCode = 'BH';
  String? dialCode;
  bool isValid = false;
  TextEditingController phone = TextEditingController();
  String? verificationCode = "";
  final auth = FirebaseAuth.instance;
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        snackbarKey.currentState?.hideCurrentSnackBar();
        phone.clear();
        return await true;
      },
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            onTap: () {
              push(context: context, screen: IntroScreen());
              snackbarKey.currentState?.hideCurrentSnackBar();
              phone.clear();
            },
            // skipp: true,
            title: "",
            image: "",
            // leadingImage: "",
            fontWeight: FontWeight.w900,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SafeArea(
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
                            "Login to continue",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                                print("CONRTY COSDDFDDDF   $dialCode");
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
                            autoValidateMode: AutovalidateMode.always,
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              leadingPadding: 10,
                              setSelectorButtonAsPrefixIcon: true,
                            ),
                            ignoreBlank: false,
                            // keyboardType: TextInputType.number,
                            keyboardType: Platform.isIOS
                                ? TextInputType.numberWithOptions(signed: true, decimal: true)
                                : TextInputType.number,
                            formatInput: false,
                            initialValue: PhoneNumber(isoCode: isoCode),
                            textFieldController: phone,
                            inputDecoration: InputDecoration(
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
                            ),
                            cursorColor: MyColors.black,
                          ),
                          // Spacer(),
                          SizedBox(height: 45),
                          CustomButton(
                            height: MediaQuery.of(context).size.height * 0.06,
                            title: "SEND OTP",
                            fontSize: 16,
                            onTap: () async {
                              print('$dialCode ${phone.text}');
                              print(isValid);
                              var pref = await SharedPreferences.getInstance();
                              var delete = await pref.getBool('isDelete');
                              print('$delete');
                              if (phone.text.isNotEmpty) {
                                if (isValid == true) {
                                  // var phoneValid = await loginController.checkPhoneNo(
                                  //     phoneNo: phone.text);
                                  // if(phoneValid==true){
                                  //   Get.to(() => VerifyPhoneScreen(
                                  //     phone: phone.text,
                                  //     dialCode: dialCode,
                                  //     isLogin: true,
                                  //   ));
                                  // }
                                  var loginToken = await FirebaseMessaging.instance.getToken();
                                  Get.to(() => VerifyPhoneScreen(
                                        phone: phone.text,
                                        dialCode: dialCode,
                                        isLogin: true,
                                      ));
                                  SharedPreferences sharedpre = await SharedPreferences.getInstance();
                                  sharedpre.setString("dailcode", dialCode.toString());
                                  sharedpre.setString("phonenumber", phone.text.trim().toString());
                                  print("Token:${loginToken}");
                                  /*  var login = await loginController.userLogin(
                                    phone.text,
                                    loginToken,
                                  );*/
                                  /* if (login == true) {
                                    print("CODE SENTTTTTTTTT");
                                    Get.to(() => VerifyPhoneScreen(
                                          phone: phone.text,
                                          dialCode: dialCode,
                                          isLogin: true,
                                        ));
                                  }*/
                                  // else if (delete == true) {
                                  //   snackBar("You are not Register yet");
                                  // }
                                  // else {
                                  //   print("REGISTER NUMBERRRR");
                                  //   snackBar("You are not Register yet");
                                  // }
                                } else {
                                  print("INVALID NUMBER ");
                                  snackBar("Please enter the valid number");
                                }
                              } else {
                                snackBar("Please enter the number");
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: TextStyle(
                                  color: MyColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  snackbarKey.currentState?.hideCurrentSnackBar();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                                  // push(
                                  //     context: context,
                                  //     screen: SignUpScreen(
                                  //       userType: "citizen",
                                  //     ),
                                  //     pushUntil: false);
                                },
                                child: Text(
                                  " Sign up",
                                  style: TextStyle(color: MyColors.orange, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
