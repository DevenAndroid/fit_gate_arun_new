// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit_gate/controller/auth_controllers/email_verify_controller.dart';
import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/auth_controllers/reg_controller.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/inro_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../global_functions.dart';
import '../setting_screen.dart';
import 'secondpage.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String? verificationId;
  final String? phone;
  final String? email;
  final bool? isLogin;
  final bool? isEmail;
  final String? userType;
  final String? id;
  final String? dialCode;
  const VerifyPhoneScreen({
    Key? key,
    this.verificationId,
    this.phone,
    this.isLogin,
    this.isEmail,
    this.email,
    this.userType,
    this.id,
    this.dialCode,
  }) : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> with SingleTickerProviderStateMixin {
  TextEditingController code = TextEditingController();
  final auth = FirebaseAuth.instance;
  final regController = Get.put(RegisterController());
  final loginController = Get.put(LoginController());
  final emailController = Get.put(EmailVerifyController());
  final bottomController = Get.put(BottomController());
  // AnimationController? _animationController;
  // int levelClock = 2 * 60;

  int secondsRemaining = 1 * 60;
  bool enableResend = false;
  Timer? timer;
  String verificationId = "";
  int? _resendToken;
  String otpCode = "";
  final submittedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 22,
      backgroundColor: MyColors.white,
      color: MyColors.orange,
      fontWeight: FontWeight.w700,
      decorationColor: MyColors.orange,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyColors.orange),
    ),
  );

  verifyPhone() async {
    try {
      loading(value: true);
      await auth.verifyPhoneNumber(
        phoneNumber: "${widget.dialCode}${widget.phone}",
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
          loading(value: false);
          verificationId = verificationID!;
          _resendToken = resendToken;
          setState(() {});
        },
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String? verification) {
          verificationId = verification!;
          print("TIME OUT");
          setState(() {});
          // print("VERIFICATION ID${verificationId}");
        },
        timeout: Duration(minutes: 1),
      );
    } on FirebaseAuthException catch (e) {
      print("ERRORRRRRRR $e");
      snackBar("Something went wrong");
    }
  }

  loginOtp() {
    if (widget.isLogin == true) {
      verifyPhone();
    }
  }

  @override
  void initState() {
    loginOtp();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(seconds: levelClock));
    //
    // _animationController!.forward();
    super.initState();
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: secondsRemaining);

    String timerText =
        '0${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return WillPopScope(
      onWillPop: () async {
        code.clear();
        return await true;
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: widget.isEmail == true ? "Verify Email" : "Verify Phone",
            image: "",
            onTap: () {
              // Get.back();
              if (widget.isEmail == true) {
                bottomController.setSelectedScreen(true, screenName: SettingScreen());
                Get.to(() => BottomNavigationScreen());
              } else {
                code.clear();
                Get.to(() => LoginScreen());
              }
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.isEmail == true ? "" : "Code is sent to ${widget.phone}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: MyColors.grey),
                    ),
                    SizedBox(height: 40),
                    Pinput(
                      controller: code,
                      autofocus: true,
                      length: widget.isEmail == true ? 4 : 6,
                      submittedPinTheme: submittedPinTheme,
                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onChanged: (v) async {
                        // if (widget.isEmail == true) {
                        //   if (code.text.length == 4) {
                        //     await checkOtp();
                        //   }
                        // } else {
                        if (code.text.length == 6) {
                          await checkOtp();
                        }
                        // }
                      },
                      onSubmitted: (pin) async {
                        otpCode = pin;
                        setState(() {});
                        // try {
                        //   var credential = PhoneAuthProvider.credential(
                        //       verificationId: widget.verificationId!,
                        //       smsCode: pin);
                        //   await auth
                        //       .signInWithCredential(credential)
                        //       .then((value) {
                        //     if (value.user != null) {}
                        //   });
                        // } catch (e) {
                        //   print("ERRORRRRRRR $e");
                        // }
                      },
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(secondsRemaining == 0 ? '' : timerText),
                          // Countdown(
                          //   animation: StepTween(
                          //     begin: levelClock,
                          //     end: 00,
                          //   ).animate(_animationController!),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Didn't receive code? ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: MyColors.grey),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: enableResend ? resendOtp : null,
                      child: Text(
                        "RESEND NEW CODE",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: enableResend ? MyColors.orange : MyColors.orange.withOpacity(.40)),
                      ),
                    ),

                    // SizedBox(height: 5),
                    // TweenAnimationBuilder(
                    //     tween: Tween(
                    //         begin: Duration(seconds: 30), end: Duration.zero),
                    //     duration: Duration(seconds: 30),
                    //     builder: (BuildContext context, Duration? value,
                    //         Widget? child) {
                    //       final min = value?.inMinutes;
                    //       final seconds = value!.inSeconds % 60;
                    //       return Text('0$min:$seconds');
                    //     }),
                    SizedBox(height: 60),
                    GetBuilder<EmailVerifyController>(builder: (cont) {
                      return CustomButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        title: "Verify",
                        fontSize: 16,
                        onTap: () async {
                          await checkOtp();
                        },
                      );
                    }),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  resendOtp() {
    if (widget.isEmail == true) {
      emailController.resendEmail(
        email: widget.email,
      );
    } else {
      // _animationController!.reset();
      // _animationController!.forward();
      print("ppppppppppppppppp");
      verifyPhone();
    }
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  checkOtp() async {
    // return false;
    if (widget.isLogin == true) {
      print("object");
      if (code.text.isEmpty) {
        snackBar("Please enter OTP");
      } else {
        try {
          var credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code.text);
          await auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              log("Firebase Login Success.......          ${value.user!.uid}");
              var loginToken = await FirebaseMessaging.instance.getToken();
              await loginController
                  .userLogin(
                widget.phone,
                loginToken,
              )
                  .then((value1) {
                if (value1 == false) return;

                log("API Login Success.......          ${value.user!.uid}");
                print(auth.currentUser!.displayName.toString() != "true");
                print(value.user!.displayName.toString() != "true");

                if (value.user!.displayName.toString() != "true") {
                  Get.to(() => UserInfoScreen());

                  log("UserInfoScreen Success.......          ${value.user!.uid}");
                  return;
                } else {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (_) => BottomNavigationScreen()), (route) => false);

                  log("BottomNavigationScreen Success.......          ${value.user!.uid}");
                }
              });
              print("LOGIN TOKENNNNNNN       --------- ${loginToken}");
            }
          });
        } on FirebaseAuthException catch (e) {
          print(e.code);
          if (e.code == 'invalid-verification-code') {
            return snackBar("Invalid OTP");
          }
          // else {
          //   return snackBar("${e.message}");
          // }
        }
      }
// var login = await loginController.userLogin(
//   widget.phone,
// );
// if (login == true) {
//   Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//           builder: (_) => BottomNavigationScreen()),
//       (route) => false);
//   // Get.off(() => BottomNavigationScreen());
// }
    } else if (widget.isEmail == true) {
      if (code.text.isEmpty) {
        snackBar("please enter code");
      } else {
        var reg = await emailController.emailVerification(
          code: code.text,
          email: widget.email,
        );
        print("EMAIL verified ****** ${widget.email}");
        if (reg == true) {
          await loginController.getUserById();
          bottomController.setSelectedScreen(true, screenName: SettingScreen());
          Get.to(() => BottomNavigationScreen());
        }
        print("DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $reg");
      }
    } else {
      print("object ELSEEEEEEEEEEEEEEEEEEEEEEEEEEE ");
      var regToken = await FirebaseMessaging.instance.getToken();
      await regController.regUser(context,
          phone: widget.phone,
          code: code.text,
          // type: widget.userType,
          verificationId: widget.verificationId,
          companyId: widget.id,
          fcmToken: regToken,
          countryCode: widget.dialCode);
      print("CODE CCCC${widget.dialCode}");
      // print(
      //     "USERRRRRRRRRRR TTYPEEEEEEEEEEEEEEE     -----------------------  ${widget.userType}");
      // print(
      //     "REG TOKENNNNNNNNNNNNNNNN     -----------------------  ${regToken}");
// if (reg == true) {
//   Get.to(() => BottomNavigationScreen());
// } else {
//   snackBar(context, "Already exits");
// }
    }
  }
}
