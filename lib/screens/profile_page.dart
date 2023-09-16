// // ignore_for_file: prefer_const_constructors
//
// import 'package:fit_gate/controller/profile_controller.dart';
// import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
// import 'package:fit_gate/screens/auth/verify_phone_screen.dart';
// import 'package:fit_gate/screens/setting_screen.dart';
// import 'package:fit_gate/utils/my_color.dart';
// import 'package:fit_gate/utils/my_images.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../custom_widgets/custom_app_bar.dart';
// import '../custom_widgets/custom_text_field.dart';
// import '../global_functions.dart';
//
// class ProfilePage extends StatefulWidget {
//   final String? title;
//   final bool? isEmail;
//   ProfilePage({Key? key, this.title, this.isEmail}) : super(key: key);
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final TextEditingController name = TextEditingController();
//
//   final TextEditingController email = TextEditingController();
//
//   var profileController = Get.put(ProfileController());
//   var model = Global.userModel!;
// /*  getData() {
//     // if (model.name!.isNotEmpty && model.email!.isNotEmpty) {
//     name.text = Global.userModel!.name!;
//     email.text = model.email!;
//     // }
//     print("NAMEEEEEEEEEEEEEEEEEEEE${model.name}");
//     // name.text = Global.userModel!.name!;
//     // email.text = Global.userModel!.email!;
//     // gender = profileController.userGender!;
//     // imgController.imgUrl = profileController.userAvatar!;
//   }*/
//   getData() {
//     name.text = model.name!;
//     email.text = model.email!;
//   }
//
//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final minutes = value.inMinutes;
//     // final seconds = value.inSeconds % 60;
//     return Scaffold(
//         appBar: PreferredSize(
//             preferredSize: Size(double.infinity, kToolbarHeight),
//             child: widget.isEmail == true
//                 ? CustomAppBar(
//                     title: "Email",
//                     actionIcon: Icons.check,
//                     image: "",
//                     actionIconOnTap: () async {
//                       profileController.addProfile(
//                           email: email.text, name: name.text);
//                       // var pref = await SharedPreferences.getInstance();
//                       // setState(() {
//                       //   pref.setString("email", email.text);
//                       // });
//                       // if (email.text.isNotEmpty) {
//                       //   profileController.userEmail = email.text;
//                       // }
//                       // if ((widget.isEmail == true && email.text.isNotEmpty) ||
//                       //     name.text.isNotEmpty) {
//                       //   profileController.userEmail = email.text;
//                       // } else if (name.text.isNotEmpty ||
//                       //     email.text.isNotEmpty) {
//                       //   profileController.userName = name.text;
//                       // }
//                       Get.to(() => SettingScreen());
//                     },
//                   )
//                 : CustomAppBar(
//                     title: "Name",
//                     actionIcon: Icons.check,
//                     image: "",
//                     actionIconOnTap: () async {
//                       profileController.addProfile(
//                           name: name.text, email: email.text);
//                       // setState(() {
//                       //   pref.setString("name", name.text);
//                       // });
//                       // if (name.text.isNotEmpty) {
//                       //   profileController.userName = name.text;
//                       // }
//                       // (widget.isEmail == true) && email.text.isNotEmpty ||
//                       //         name.text.isNotEmpty
//                       //     ? profileController.userEmail = email.text
//                       //     : profileController.userName = name.text;
//                       Get.to(() => SettingScreen());
//                     },
//                   )),
//         body: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: widget.isEmail == true
//               ? SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         autofocus: true,
//                         prefixIcon: MyImages.account,
//                         controller: email,
//                         hint: "Enter your email",
//                         label: "Email",
//                       ),
//                       SizedBox(height: 100),
//                       CustomButton(
//                         onTap: () {
//                           Get.to(() => VerifyPhoneScreen(isEmail: true));
//                         },
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         height: MediaQuery.of(context).size.height * 0.047,
//                         title: "Verify email",
//                         fontSize: 16,
//                         fontColor: MyColors.white,
//                         bgColor: MyColors.orange,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       /* TweenAnimationBuilder(
//                         tween: Tween(
//                             begin: Duration(seconds: 30), end: Duration.zero),
//                         duration: Duration(minutes: 1),
//                         builder: (BuildContext context, Duration? value,
//                             Widget? child) {
//                           final minutes = value?.inMinutes;
//                           final seconds = value!.inSeconds % 60;
//                           return Text('$minutes:$seconds');
//                         },
//                       )*/
//                     ],
//                   ),
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         autofocus: true,
//                         prefixIcon: MyImages.account,
//                         controller: name,
//                         hint: "Enter your name",
//                         label: "Name",
//                       ),
//                     ],
//                   ),
//                 ),
//         ));
//   }
// }
