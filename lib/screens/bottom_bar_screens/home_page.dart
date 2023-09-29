// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_gate/controller/auth_controllers/login_controller.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/controller/get_company_controller.dart';
import 'package:fit_gate/controller/image_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/controller/notification_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/explore.dart';
import 'package:fit_gate/screens/gym_details_screens/gym_details_screen.dart';
import 'package:fit_gate/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/subscription_controller.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../models/user_model.dart';
import '../../utils/my_color.dart';
import '../../utils/my_images.dart';
import 'map_page.dart';

List<String> fg = [
  "Limited gyms (Free)",
  "Access to emerald only benefits",
  "Access to ruby only benefits",
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final indexCon = Get.put(ImageController());
  final notificationCon = Get.put(NotificationController());
  final subscriptionController = Get.put(SubscriptionController());
  final mapController = Get.put(MapController());
  final banner = Get.put(BannerController());
  final login = Get.put(LoginController());
  int? index;
  // PageController pageController = PageController(initialPage: 0);
  CarouselController carouselController = CarouselController();

  getSubscriptionList() async {
    await login.getUserById();
    print("MNAME---> ${Global.userModel?.middleName}");
    // await mapController.getCurrentLocation();
    var pref = await SharedPreferences.getInstance();
    var data = await jsonDecode(pref.getString('isLogin').toString());
    UserModel setData = UserModel.fromJson(data);
    Global.userModel = setData;
    var plan = await subscriptionController.activeSubscriptionPlan();
    print("SUB PLAN---> $plan");
    // if (plan == true) {
    //   ActiveSubscriptionModel activeData = ActiveSubscriptionModel.fromJson(
    //       await jsonDecode(pref.getString('isActivated').toString()));
    //   Global.activeSubscriptionModel = activeData;
    // }
    mapController.getLocation1();
    mapController.getFilterData(
        isCurrentLocation: true,
        // lat: mapController.position?.latitude.toString(),
        // lon: mapController.position?.longitude.toString(),
        lat: 26.0667.toString(),
        lon: 50.55770000000007.toString());
    await subscriptionController.subscriptionListGet();
    await banner.getBanner();
    // InAppUpdate.checkForUpdate().then((updateInfo) {
    //   log("^^^^^^^^^^^ $updateInfo");
    //   if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
    //     if (updateInfo.immediateUpdateAllowed) {
    //       // Perform immediate update
    //       InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
    //         if (appUpdateResult == AppUpdateResult.success) {
    //           //App Update successful
    //         }
    //       });
    //     } else if (updateInfo.flexibleUpdateAllowed) {
    //       //Perform flexible update
    //       InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
    //         if (appUpdateResult == AppUpdateResult.success) {
    //           //App Update successful
    //           InAppUpdate.completeFlexibleUpdate();
    //         }
    //       });
    //     }
    //   }
    // });
  }

  int pageIndex = 0;

  @override
  void initState() {
    getSubscriptionList();
    super.initState();
  }

  // countNotification() async {
  //   await notificationCon.countNotification();
  // }
  //
  // @override
  // void initState() {
  //   countNotification();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Home",
        leadingImage: "",
        fontWeight: FontWeight.w900,
      ),
      body: SingleChildScrollView(
        //   padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Global.userModel?.phoneNumber != null
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Get.off(() => LoginScreen());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            color: MyColors.grey,
                            child: Center(
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "Log in ",
                                  style: TextStyle(color: MyColors.orange, fontSize: 16.5, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: " to enjoy the full experience",
                                  style: TextStyle(color: MyColors.white, fontSize: 16, fontWeight: FontWeight.normal),
                                )
                              ])),
                            ),
                          ),
                        ),
                  SizedBox(height: 2),
                  GetBuilder<BannerController>(builder: (banner) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CarouselSlider(
                            carouselController: carouselController, // Give the controller
                            options: CarouselOptions(
                                // initialPage: 0,
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                padEnds: true,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 2),
                                autoPlayCurve: Curves.linear,
                                onPageChanged: (val, _) {
                                  pageIndex = val;
                                  setState(() {});
                                }),

                            items: banner.getBannerList.map((featuredImage) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl: '${featuredImage.image}',
                                    placeholder: (c, __) => Center(
                                        child: CircularProgressIndicator(
                                      color: MyColors.orange,
                                      strokeWidth: 1.5,
                                    )),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ImageButton(
                                  height: 12,
                                  width: 12,
                                  image: MyImages.arrowLeft,
                                  color: MyColors.white,
                                  bgColor: MyColors.orange,
                                  boxShape: BoxShape.circle,
                                  onTap: () {
                                    carouselController.previousPage(
                                        duration: Duration(seconds: 1), curve: Curves.easeOut);
                                  },
                                ),
                                ImageButton(
                                  height: 12,
                                  width: 12,
                                  image: MyImages.arrowRight,
                                  color: MyColors.white,
                                  bgColor: MyColors.orange,
                                  boxShape: BoxShape.circle,
                                  onTap: () {
                                    if (pageIndex == banner.getBannerList.length - 1) {
                                      print("||||||| $pageIndex");
                                      carouselController.animateToPage(0,
                                          duration: Duration(seconds: 1), curve: Curves.easeOut);
                                    } else {
                                      carouselController.nextPage(
                                          duration: Duration(seconds: 1), curve: Curves.easeOut);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // PageView.builder(
                      //     controller: pageController,
                      //     scrollDirection: Axis.horizontal,
                      //     onPageChanged: (val) {},
                      //
                      //     // shrinkWrap: true,
                      //     itemCount: banner.getBannerList.length,
                      //     itemBuilder: (c, i) {
                      //       return ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: Container(
                      //           // height: 170,
                      //           // width: MediaQuery.of(context).size.width,
                      //           // height: MediaQuery.of(context).size.height * 0.22,
                      //           decoration: BoxDecoration(
                      //             color: Colors.transparent,
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           child: Stack(
                      //             fit: StackFit.expand,
                      //             children: [
                      //               CachedNetworkImage(
                      //                 fit: BoxFit.cover,
                      //                 imageUrl:
                      //                     '${banner.getBannerList[i].image}',
                      //                 placeholder: (c, __) => Center(
                      //                     child: CircularProgressIndicator(
                      //                   color: MyColors.orange,
                      //                   strokeWidth: 1.5,
                      //                 )),
                      //               ),
                      //               Positioned(
                      //                 top:
                      //                     MediaQuery.of(context).size.height *
                      //                         0.09,
                      //                 left: 5,
                      //                 right: 5,
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     ImageButton(
                      //                       height: 12,
                      //                       width: 12,
                      //                       image: MyImages.arrowLeft,
                      //                       color: MyColors.black,
                      //                       bgColor: MyColors.white,
                      //                       boxShape: BoxShape.circle,
                      //                       onTap: () {
                      //                         pageController.previousPage(
                      //                             duration:
                      //                                 Duration(seconds: 1),
                      //                             curve: Curves.easeOut);
                      //                       },
                      //                     ),
                      //                     ImageButton(
                      //                       height: 12,
                      //                       width: 12,
                      //                       image: MyImages.arrowRight,
                      //                       color: MyColors.black,
                      //                       bgColor: MyColors.white,
                      //                       boxShape: BoxShape.circle,
                      //                       onTap: () {
                      //                         pageController.nextPage(
                      //                             duration:
                      //                                 Duration(seconds: 1),
                      //                             curve: Curves.easeOut);
                      //                       },
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     }),
                    );
                  }),
                  SizedBox(height: 15),
                  GetBuilder<BottomController>(
                      builder: (controller) => CustomButton(
                            onTap: () {
                              /*      controller.getIndex(1);
                              controller.setSelectedScreen(true,
                                  screenName: ExplorePage());*/
                              controller.setSelectedScreen(false);
                              controller.getIndex(1);
                            },
                            title: "Explore more offers",
                            height: MediaQuery.of(context).size.height * 0.06,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                  SizedBox(height: 15),
                  Global.userModel?.phoneNumber == null
                      ? SizedBox()
                      : Text(
                          "Subscription Plan: Free/Pro",
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  SizedBox(height: 10),
                  Container(
                    height: 163,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MyImages.subBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: MyColors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                              child: Text(
                                "Enjoy free Offers",
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 20,
                          child: ImageButton(
                            image: MyImages.pro,
                            height: 35,
                            width: 35,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            "Subscribe to pro",
                            style: TextStyle(
                              color: MyColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GetBuilder<BottomController>(builder: (controller) {
                              return CustomButton(
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: MediaQuery.of(context).size.height * 0.033,
                                title: "Join",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                borderColor: Colors.transparent,
                                fontColor: MyColors.orange,
                                bgColor: MyColors.white,
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  controller.getIndex(0);
                                  controller.setSelectedScreen(true, screenName: Subscription());
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Nearby Gyms",
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(
                        "assets/pin.png",
                        height: 30,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            GetBuilder<MapController>(builder: (data) {
              return data.nearbyGymList.isEmpty
                  ? Center(child: Text("Nearby gyms not found"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.nearbyGymList.length < 4 ? data.nearbyGymList.length : 3,
                      itemBuilder: (c, i) {
                        var gymData = data.nearbyGymList[i];
                        return GetBuilder<BottomController>(builder: (controller) {
                          return GymTile(
                            gymModel: gymData,
                            onClick: () {
                              index = i;
                              setState(() {});
                              controller.getIndex(1);
                              controller.setSelectedScreen(
                                true,
                                screenName: GymDetailsScreen(
                                  index: index,
                                  gymDetailsModel: gymData,
                                ),
                              );
                              Get.to(() => BottomNavigationScreen());
                            },
                          );
                        });
                      });
            }),
          ],
        ),
      ),
    );
  }
}
