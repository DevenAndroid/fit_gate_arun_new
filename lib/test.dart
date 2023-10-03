import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/custom_widgets/custom_app_bar.dart';
import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_account_card.dart';
import 'package:fit_gate/custom_widgets/custom_cards/custom_join_fit_card.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'screens/bottom_bar_screens/home_page.dart';
import 'utils/my_images.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int chooseOption = 0;
  final bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);
        return bottomController.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CustomAppBar(
              title: "Subscription",
              onTap: () {
                bottomController.getIndex(0);
                bottomController.setSelectedScreen(true, screenName: HomePage());
                Get.to(BottomNavigationScreen());
              },
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                          color: chooseOption == 1 ? MyColors.orange.withOpacity(.10) : MyColors.grey.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 24,
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
                          color: chooseOption == 2 ? MyColors.orange.withOpacity(.10) : MyColors.grey.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 24,
                        ),
                        iconSize: 17,
                        height: MediaQuery.of(context).size.height * 0.086,
                        title: "18BHD / year",
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
                  height: MediaQuery.of(context).size.height * 0.066,
                  title: "Proceed to Payment",
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
//  Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Image.asset(
//                     MyImages.logo,
//                     height: 110,
//                     width: 200,
//                   ),
//                   // Spacer(),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: MyColors.orange,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.asset(
//                         MyImages.intro,
//                         height: 20,
//                         width: 20,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 30),
//               Positioned(
//                 top: 100,
//                 child: Text(
//                   "Muscle Up Your\nBody Physique",
//                   style: TextStyle(
//                     color: MyColors.white,
//                     fontSize: 33,
//                     height: 1.2,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Positioned(
//                 top: 200,
//                 child: Text(
//                   "Explore amazing features and offers with\nPro Subscription",
//                   style: TextStyle(
//                     color: MyColors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w100,
//                   ),
//                 ),
//               ),
//               // Spacer(),
//               Positioned(
//                 bottom: 80,
//                 left: 0,
//                 right: 0,
//                 child: CustomButton(
//                   title: "Get Started",
//                   borderRadius: BorderRadius.circular(12),
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   onTap: () async {
//                     SharedPreferences pref =
//                         await SharedPreferences.getInstance();
//                     pref.setInt("intro", 1);
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) => SignUpScreen()),
//                         (route) => false);
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Positioned(
//                 bottom: 10,
//                 left: 0,
//                 right: 0,
//                 child: CustomButton(
//                   title: "Login",
//                   bgColor: Colors.orange,
//                   borderColor: MyColors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   onTap: () async {
//                     SharedPreferences pref =
//                         await SharedPreferences.getInstance();
//                     pref.setInt("intro", 1);
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) => LoginScreen()),
//                         (route) => false);
//                   },
//                 ),
//               ),
