// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/controller/delete_user_controller.dart';
import 'package:fit_gate/controller/profile_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/custom_all_small_button.dart';
import 'package:fit_gate/custom_widgets/custom_text_field.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/splash_screen.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_sheet/profile_bottom_sheet.dart';
import '../controller/auth_controllers/email_verify_controller.dart';
import '../controller/image_controller.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_btns/custom_button.dart';
import '../custom_widgets/custom_cards/custom_about_card.dart';
import '../custom_widgets/custom_cards/custom_join_fit_card.dart';
import '../custom_widgets/custom_circle_avatar.dart';
import '../custom_widgets/dialog/custom_dialog.dart';
import '../utils/my_color.dart';
import 'auth/verify_phone_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController cpr = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  var profileController = Get.put(ProfileController());
  var imgController = Get.put(ImageController());
  var emailVerifyController = Get.put(EmailVerifyController());
  var loginController = Get.put(LoginController());
  var bottomController = Get.put(BottomController());
  var deleteUserController = Get.put(DeleteUserController());
  final formKey = GlobalKey<FormState>();

  // Newly added Fields
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 365 * 18));
  String selectedCountry = "";
  String selectedArea = "";
  final TextEditingController dobController = TextEditingController();

  bool notify = true;
  int chooseOption = 0;
  String? gender;
  String txt = "";
  List<String> packageList = ['Sapphire', 'Emerald', 'Ruby'];
  var dropdownValue;
  var data = Global.userModel;

  updateNew() {
    dobController.text = Global.userModel!.dob ?? "";
    selectedCountry = Global.userModel!.countryName ?? "";
    if (!items.contains(selectedCountry)) {
      selectedCountry = "";
    }
    selectedArea = Global.userModel!.area ?? "";
    if (selectedCountry == "Bahrain") {
      if (!Bahrain.contains(selectedArea)) {
        selectedArea = "";
      }
    }
    if (selectedCountry == "Saudi Arabia") {
      if (!SaudiArabia.contains(selectedArea)) {
        selectedArea = "";
      }
    }
    if (dobController.text.trim().isNotEmpty) {
      print("Assigning date.........     ");
      try {
        dateOfBirth = DateFormat("yyyy-MM-dd").parse(dobController.text.trim());
      } catch (e) {}
      // dateOfBirth
    }
  }

  Future getData() async {
    loading(value: true);
    await loginController.getUserById();
    loading(value: false);
    if (Global.userModel?.phoneNumber != null) {
      if (Global.userModel?.name != null) {
        name.text =
            (Global.userModel!.name == null ? "" : Global.userModel!.name!);
        lName.text = (Global.userModel!.lastName == null
            ? ""
            : Global.userModel!.lastName!);
        mName.text = (Global.userModel!.middleName == null
            ? ""
            : Global.userModel!.middleName!);
        updateNew();
        gender = Global.userModel!.gender;
        email.text =
            (Global.userModel!.email == null ? "" : Global.userModel!.email!);
        dropdownValue = Global.userModel?.subscriptionPlan;
        imgController.imgUrl = Global.userModel?.avatar;
        if (mounted) {
          setState(() {});
        }
        print(
            "IMAGEURLLLLLL ---------- IFFFF +++++++++++++++     ${imgController.imgUrl}");
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await loginController.getUserById();
        name.text =
            (Global.userModel!.name == null ? "" : Global.userModel!.name!);
        lName.text = (Global.userModel!.lastName == null
            ? ""
            : Global.userModel!.lastName!);
        mName.text = (Global.userModel!.middleName == null
            ? ""
            : Global.userModel!.middleName!);
        updateNew();
        gender = Global.userModel!.gender;
        email.text =
            (Global.userModel!.email == null ? "" : Global.userModel!.email!);
        var turnOnNotification = await pref.getBool('isNotifyOn');
        turnOnNotification == false ? notify = false : notify = true;
        print("TURNNNNN ONNNNNNNNNN -------------     ${turnOnNotification}");
        imgController.imgUrl = Global.userModel?.avatar;
        print(
            "IMAGEURLLLLLL ---------- ELSEEEEE +++++++++++++++     ${imgController.imgUrl}");
        setState(() {});
      }
    }
  }

  pickDate({required Function(DateTime gg) onPick}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    // updateValues();
  }

  var items = [
    'Bahrain',
    'Saudi Arabia',
  ];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedArea);
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(3);

        return bottomController.setSelectedScreen(true,
            screenName: AccountScreen());
      },
      child: SafeArea(
          child: Scaffold(
              appBar: CustomAppBar(
                  title: "Setting",
                  actionIcon: Icons.check,
                  onTap: () {
                    bottomController.setSelectedScreen(true,
                        screenName: AccountScreen());
                    Get.to(() => BottomNavigationScreen());
                  },
                  actionIconOnTap: () async {
                    if (email.text.isNotEmpty &&
                        Global.userModel?.phoneNumber == null) {
                      print("object");
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email.text)) {
                        showToast("Please enter valid email");
                      }
                    }
                    // else if (name.text.isEmpty) {
                    //   print("1");
                    //   return snackBar("Please enter the name");
                    // } else if (mName.text.isEmpty) {
                    //   print("3");
                    //   return snackBar("Please enter full name");
                    // } else if (lName.text.isEmpty) {
                    //   print("4");
                    //   return snackBar("Please enter full name");
                    // }
                    else {
                      if (!formKey.currentState!.validate()) return;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      print("${phone.text.isNotEmpty}");

                      profileController.addProfile(
                        name: name.text,
                        mName: mName.text,
                        lName: lName.text,
                        email: email.text,
                        gender: gender,
                        avatar: imgController.imgUrl,
                        area: selectedArea,
                        country_name: selectedCountry,
                        dob: dobController.text.trim(),
                        subscriptionType: dropdownValue,
                      );
                    }
                  }),
              body: RefreshIndicator(
                onRefresh: () async {
                  getData();
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<ImageController>(builder: (cont) {
                              return Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        CustomCameraSheet()
                                            .cameraBottomSheet(context);

                                        print(cont.imgUrl);
                                      },
                                      child: cont.imgUrl == null &&
                                              Global.userModel?.avatar == null
                                          ? CustomCircleAvatar(
                                              image: AssetImage(
                                                  "assets/images/1.png"))
                                          : CachedNetworkImage(
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 45,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (c, url) =>
                                                  CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 45,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    color: MyColors.orange,
                                                  ),
                                                ),
                                              ),
                                              imageUrl:
                                                  "${imgController.imgUrl}",
                                              errorWidget: (c, u, r) =>
                                                  Container(),
                                            ),
                                      // CustomCircleAvatar(
                                      //         image: NetworkImage(
                                      //             "${imgController.imgUrl}")),
                                    ),
                                    Positioned(
                                        bottom: 5,
                                        left: 67,
                                        child: Container(
                                          padding: EdgeInsets.all(3.5),
                                          decoration: BoxDecoration(
                                              color: MyColors.orange,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 13,
                                            color: MyColors.white,
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: 10),
                            CustomTextField(
                              prefixIcon: MyImages.account,
                              controller: name,
                              hint: "Enter your name",
                              label: "Name",
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              controller: mName,
                              prefixIcon: MyImages.account,
                              hint: "Your middle name",
                              label: "Middle Name",
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              controller: lName,
                              prefixIcon: MyImages.account,
                              hint: "Your last name",
                              label: "Last Name",
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              prefixIcon: MyImages.phone,
                              readOnly: true,
                              hint: Global.userModel?.phoneNumber,
                              hintColor: MyColors.black,
                              label: "Phone",
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: MyImages.privacyPolicy,
                              readOnly: true,
                              controller: cpr,
                              hint: "${Global.userModel?.cpr_no ?? "cpr no"}",
                              // hint: "0",
                              label: "CPR",
                              hintColor: MyColors.black,
                              maxLength: 9,
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              onTap: () {
                                pickDate(onPick: (DateTime gg) {
                                  dateOfBirth = gg;
                                  dobController.text =
                                      DateFormat("yyyy-MM-dd").format(gg);
                                  setState(() {});
                                });
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please select your DOB";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              prefixIcon: MyImages.privacyPolicy,
                              readOnly: true,
                              controller: dobController,
                              hint: "${Global.userModel?.cpr_no ?? "cpr no"}",
                              // hint: "0",
                              label: "Date of birth",
                              hintColor: MyColors.black,
                              maxLength: 9,
                            ),

                            ///
                            SizedBox(height: 7),
                            Text(
                              "Country",
                              style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 1.5),
                            DropdownButtonFormField(
                                value: selectedCountry.isEmpty
                                    ? null
                                    : selectedCountry,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (selectedCountry.isEmpty) {
                                    return "Please select country";
                                  }
                                  return null;
                                },
                                items: items
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                decoration: InputDecoration(
                                  counterText: "",
                                  prefixIcon: Icon(
                                    Icons.outlined_flag_rounded,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 20, bottom: 10, right: 10),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey, width: 1.5),
                                  ),
                                  hintText: "Select Country",
                                  hintStyle: TextStyle(
                                    color: MyColors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.orange, width: 1.5),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value == null) return;
                                  selectedArea = "";
                                  selectedCountry = value;
                                  setState(() {});
                                }),

                            SizedBox(height: 7),
                            Text(
                              "Area",
                              style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 1.5),
                            if (selectedCountry == "Bahrain")
                              DropdownButtonFormField(
                                key: ValueKey(
                                    DateTime.now().millisecondsSinceEpoch),
                                value:
                                    selectedArea.isEmpty ? null : selectedArea,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: Bahrain.map((e) => e.trim())
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (newValue == null) return;
                                    selectedArea = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (selectedArea.isEmpty) {
                                    return "Please select area";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  prefixIcon: Icon(
                                    Icons.outlined_flag_rounded,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 20, bottom: 10, right: 10),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey, width: 1.5),
                                  ),
                                  hintText: "Select Area",
                                  hintStyle: TextStyle(
                                    color: MyColors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.orange, width: 1.5),
                                  ),
                                ),
                              ),
                            if (selectedCountry == "Saudi Arabia")
                              DropdownButtonFormField(
                                key: ValueKey(
                                    DateTime.now().millisecondsSinceEpoch),
                                value:
                                    selectedArea.isEmpty ? null : selectedArea,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                validator: (value) {
                                  if (selectedArea.isEmpty) {
                                    return "Please select area";
                                  }
                                  return null;
                                },
                                items: SaudiArabia.map((e) => e.trim())
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue == null) return;
                                  selectedArea = newValue;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  prefixIcon: Icon(
                                    Icons.outlined_flag_rounded,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 20, bottom: 10, right: 10),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey, width: 1.5),
                                  ),
                                  hintText: "Select Area",
                                  hintStyle: TextStyle(
                                    color: MyColors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.grey.withOpacity(.40),
                                        width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: MyColors.orange, width: 1.5),
                                  ),
                                ),
                              ),

                            ///

                            SizedBox(height: 7),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: CustomTextField(
                                      prefixIcon: MyImages.email,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: email,
                                      hintColor: Global.userModel
                                                  ?.emailVerifyStatus ==
                                              '1'
                                          ? MyColors.black
                                          : MyColors.grey,
                                      hint:
                                          Global.userModel?.emailVerifyStatus ==
                                                  '1'
                                              ? Global.userModel?.email ??
                                                  "Enter your email"
                                              : "Enter your email",
                                      label: "Email",
                                      readOnly:
                                          Global.userModel?.emailVerifyStatus ==
                                                  '1'
                                              ? true
                                              : false,
                                      onChanged: (newText) async {
                                        txt = newText;
                                        setState(() {});
                                      }),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 13),
                                      Global.userModel?.emailVerifyStatus == '1'
                                          // &&
                                          //     (txt.isEmpty ||
                                          //         Global.userModel?.email == txt)
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade500,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.check,
                                                  color: MyColors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            )
                                          : CustomButton(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.035,
                                              title: "Verify",
                                              fontSize: 13.5,
                                              fontColor: MyColors.white,
                                              bgColor: MyColors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () async {
                                                if (email.text.isEmpty) {
                                                  showToast(
                                                      "Please enter email");
                                                } else if (!RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(email.text)) {
                                                  showToast(
                                                      "please enter valid email");
                                                } else {
                                                  // if (((name.text.isNotEmpty &&
                                                  //             mName.text
                                                  //                 .isNotEmpty) &&
                                                  //         (mName.text
                                                  //                 .isNotEmpty &&
                                                  //             lName.text
                                                  //                 .isNotEmpty) &&
                                                  //         (name.text.isNotEmpty &&
                                                  //             lName.text
                                                  //                 .isNotEmpty)) ||
                                                  //     ((name.text.isEmpty &&
                                                  //             mName.text
                                                  //                 .isEmpty) &&
                                                  //         (mName.text.isEmpty &&
                                                  //             lName.text
                                                  //                 .isEmpty) &&
                                                  //         (name.text.isEmpty &&
                                                  //             lName.text
                                                  //                 .isEmpty)))
                                                  // {
                                                  // snackBar(
                                                  //     "Please enter full name");
                                                  // SharedPreferences pref =
                                                  //     await SharedPreferences
                                                  //         .getInstance();
                                                  // pref.setString(
                                                  //     'email', email.text);

                                                  // } else {
                                                  //   snackBar(
                                                  //       "Please enter full name");
                                                  // }
                                                  // controllerFunction(true);
                                                  // if ((name.text.isEmpty &&
                                                  //         mName.text.isEmpty) &&
                                                  //     (mName.text.isEmpty &&
                                                  //         lName.text.isEmpty) &&
                                                  //     (name.text.isEmpty &&
                                                  //         lName.text.isEmpty)) {
                                                  //   profileController.addProfile(
                                                  //     name: name.text.isEmpty
                                                  //         ? Global.userModel?.name
                                                  //         : name.text,
                                                  //     email: email.text.isEmpty
                                                  //         ? Global.userModel?.email
                                                  //         : email.text,
                                                  //     mName: mName.text.isEmpty
                                                  //         ? Global
                                                  //             .userModel?.middleName
                                                  //         : mName.text,
                                                  //     lName: lName.text.isEmpty
                                                  //         ? Global.userModel?.lastName
                                                  //         : lName.text,
                                                  //     gender: gender,
                                                  //     avatar: imgController.imgUrl,
                                                  //   );
                                                  //   emailVerifyController
                                                  //       .sendEmailVerification(
                                                  //     email: email.text,
                                                  //     userId: Global.userModel?.id
                                                  //         .toString(),
                                                  //   );
                                                  //   Navigator.pushAndRemoveUntil(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //           builder: (_) =>
                                                  //               VerifyPhoneScreen(
                                                  //                 isEmail: true,
                                                  //                 email: email.text,
                                                  //               )),
                                                  //       (route) => false);
                                                  //   print("MOTIII CONDITIONNN");
                                                  // } else {
                                                  //   print("6oti CONDITION");
                                                  // }
                                                  profileController.addProfile(
                                                    isEmail: true,
                                                    name: name.text.isEmpty
                                                        ? Global.userModel?.name
                                                        : name.text,
                                                    email: email.text,
                                                    dob: dobController.text
                                                        .trim(),
                                                    country_name:
                                                        selectedCountry,
                                                    area: selectedArea,
                                                    mName: mName.text.isEmpty
                                                        ? Global.userModel
                                                            ?.middleName
                                                        : mName.text,
                                                    lName: lName.text.isEmpty
                                                        ? Global
                                                            .userModel?.lastName
                                                        : lName.text,
                                                    gender: gender,
                                                    avatar:
                                                        imgController.imgUrl,
                                                  );
                                                  emailVerifyController
                                                      .sendEmailVerification(
                                                    email: email.text,
                                                    userId: Global.userModel?.id
                                                        .toString(),
                                                  );
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              VerifyPhoneScreen(
                                                                isEmail: true,
                                                                email:
                                                                    email.text,
                                                              )),
                                                      (route) => false);
                                                }
                                                // }
                                              }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      color: MyColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Switch(
                                  onChanged: (val) async {
                                    var pref =
                                        await SharedPreferences.getInstance();
                                    notify = val;
                                    notify == false
                                        ? await pref.setBool(
                                            'isNotifyOn', false)
                                        : await pref.setBool(
                                            'isNotifyOn', true);
                                    print(
                                        "NOTIFICATIONNNNN    VALLlll    $notify");
                                    setState(() {});
                                  },
                                  value: notify,
                                  activeColor: MyColors.white,
                                  activeTrackColor: MyColors.orange,
                                  inactiveThumbColor: MyColors.white,
                                  inactiveTrackColor: MyColors.grey,
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Gender",
                              style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomRadio(
                                  title: "Male",
                                  groupValue: gender,
                                  value: "male",
                                  onChanged: (val) {
                                    gender = val;
                                    setState(() {});
                                    print(gender);
                                  },
                                ),
                                SizedBox(width: 10),
                                CustomRadio(
                                  title: "Female",
                                  groupValue: gender,
                                  value: "female",
                                  onChanged: (val) {
                                    gender = val;
                                    setState(() {});
                                    print(gender);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CustomAboutCard(
                              onTap: () {},
                              title: "Rate the app",
                              icon: MyImages.star,
                            ),
                            SizedBox(height: 10),
                            CustomAboutCard(
                              onTap: () {
                                FlutterShare.share(
                                    title: 'jbh',
                                    linkUrl: Platform.isIOS
                                        ? "https://apps.apple.com/us/app/fitgate/id6444258614"
                                        : "https://play.google.com/store/apps/details?id=com.antigecommerce.fitgate");
                              },
                              title: "Share the app",
                              icon: MyImages.share,
                            ),
                            SizedBox(height: 10),
                            CustomAboutCard(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => launchWebView(
                                            "https://www.fitgate.live/")));
                              },
                              title: "About Us",
                              icon: MyImages.aboutUs,
                            ),
                            SizedBox(height: 10),
                            CustomAboutCard(
                              onTap: () {},
                              title: "TOS",
                              icon: MyImages.tos,
                            ),
                            SizedBox(height: 10),
                            CustomAboutCard(
                              onTap: () {},
                              title: "Privacy Policy",
                              icon: MyImages.privacyPolicy,
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CustomJoinFitCard(
                                    onClick: () async {
                                      chooseOption = 1;
                                      setState(() {});
                                      showDialog(
                                          context: context,
                                          builder: (_) => CustomDialog(
                                                title:
                                                    "Are sure you want to logout?",
                                                label1: "Yes",
                                                label2: "No",
                                                cancel: () {
                                                  Get.back();
                                                },
                                                onTap: () async {
                                                  await FirebaseAuth.instance
                                                      .signOut();
                                                  var pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await pref.setBool(
                                                      "isLogout", true);
                                                  await pref.remove('isLogin');
                                                  await pref
                                                      .remove('isActivated');
                                                  Global.userModel = null;
                                                  Global.activeSubscriptionModel =
                                                      null;
                                                  bottomController.resetIndex();
                                                  push(
                                                      context: context,
                                                      screen: SplashScreen(),
                                                      pushUntil: true);
                                                },
                                              ));
                                    },
                                    selectedIndex: chooseOption,
                                    index: 1,
                                    boxShadow: BoxShadow(
                                      color: MyColors.grey.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 24,
                                    ),
                                    icon: Icons.logout,
                                    iconSize: 16,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    title: "Log Out",
                                    borderRadius: BorderRadius.circular(10),
                                    img: MyImages.logOut,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 4,
                                  child: GetBuilder<DeleteUserController>(
                                      builder: (controller) {
                                    return CustomJoinFitCard(
                                      onClick: () async {
                                        chooseOption = 2;
                                        setState(() {});
                                        showDialog(
                                            context: context,
                                            builder: (_) => CustomDialog(
                                                  title:
                                                      "Are sure you want to delete account?",
                                                  label1: "Yes",
                                                  label2: "No",
                                                  cancel: () {
                                                    Get.back();
                                                  },
                                                  onTap: () async {
                                                    var delete =
                                                        await deleteUserController
                                                            .deleteUser(
                                                      Global.userModel?.id
                                                          .toString(),
                                                    );
                                                    if (delete == true) {
                                                      var pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await pref.setBool(
                                                          "isDelete", true);
                                                      print("$delete");
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginScreen()),
                                                          (route) => false);
                                                    }
                                                  },
                                                ));
                                      },
                                      selectedIndex: chooseOption,
                                      index: 2,
                                      icon: Icons.delete_outline_rounded,
                                      iconSize: 18,
                                      boxShadow: BoxShadow(
                                        color: MyColors.grey.withOpacity(0.15),
                                        spreadRadius: 2,
                                        blurRadius: 24,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      title: "Delete Account",
                                      borderRadius: BorderRadius.circular(10),
                                      img: MyImages.delete,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))),
    );
  }

  // Future<String> getUrl() async {
  //   if (Platform.isIOS) {
  //     String isIos = "https://apps.apple.com/us/app/fitgate/id6444258614";
  //     await launchUrl(
  //         Uri.parse("https://apps.apple.com/us/app/fitgate/id6444258614"));
  //     return isIos;
  //   } else {
  //     String isAndroid =
  //         'https://play.google.com/store/apps/details?id=com.antigecommerce.fitgate';
  //     await launchUrl(Uri.parse(
  //         "https://play.google.com/store/apps/details?id=com.antigecommerce.fitgate"));
  //     return isAndroid;
  //   }
  // }
}

var Bahrain = [
  'Hamad Town',
  'Riffa',
  "Askar",
  "Sanad",
  "Hamala",
  "Manama",
  "Seef district",
  "Sitra",
  "Isa town",
  "Zallaq",
  "Saar",
  "Madinat salman",
  "Barbar",
  "Sannabis",
  "Awali",
  "Jidhafs",
  "Malikya",
  "Zinj",
  "Budaiya",
  "Muharraq",
];
var SaudiArabia = [
  "Al-Shargeya",
  "Mecca",
  "Almadina",
  "Al-Jouf",
  "Tabouk",
  "Hai’l",
  "Al-Riyadh",
  "Al-Qassim",
  "Najran",
  "Jazan",
  "Al-baha",
  "Alhodud Al-Shamaleya",
  "Aseer",
];
