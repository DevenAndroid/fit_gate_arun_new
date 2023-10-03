// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/controller/check_in_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_controller.dart';
import '../controller/image_controller.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_cards/activity_log_card.dart';
import '../utils/my_color.dart';

class ActivityLogsScreen extends StatefulWidget {
  final String? result;
  const ActivityLogsScreen({Key? key, this.result}) : super(key: key);

  @override
  State<ActivityLogsScreen> createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<ActivityLogsScreen> {
  var imgController = Get.put(ImageController());
  var checkInController = Get.put(CheckInController());
  final bottomController = Get.put(BottomController());

  getActivityLog() async {
    await checkInController.checkInLog();
  }

  @override
  void initState() {
    getActivityLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(3);

        return bottomController.setSelectedScreen(true, screenName: AccountScreen());
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Activity Logs",
            // image: MyImages.notification,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(MyImages.activityLog), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Expanded(
                            flex: 1,
                            child: imgController.imgUrl == null || Global.userModel?.avatar == ""
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage("assets/images/1.png"),
                                  )
                                : CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) => CircleAvatar(
                                      radius: 45,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (c, url) => CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 45,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ),
                                    imageUrl: "${imgController.imgUrl}",
                                    errorWidget: (c, u, r) => Container(),
                                  ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            flex: 4,
                            child: Text(
                              Global.userModel?.name ?? "Username",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: MyColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /* CustomAccountCard(
                  title: Global.userModel?.name ?? "Username",
                  bgImg: MyImages.activityLog,
                  child: imgController.imgUrl == null ||
                          Global.userModel?.avatar == ""
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/1.png"),
                        )
                      : CachedNetworkImage(
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 45,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (c, url) => CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                          imageUrl: "${imgController.imgUrl}",
                          errorWidget: (c, u, r) => Container(),
                        ),
                  // CircleAvatar(
                  //         radius: 30,
                  //         backgroundImage:
                  //             NetworkImage("${imgController.imgUrl}"),
                  //       ),
                ),*/
                SizedBox(height: 10),
                Expanded(
                  child: GetBuilder<CheckInController>(builder: (controller) {
                    return controller.checkInList.isEmpty
                        ? Center(child: Text("You don't have activity logs yet"))
                        : ListView.builder(
                            cacheExtent: 9999,
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.checkInList.length,
                            itemBuilder: (c, i) {
                              var data = controller.checkInList[i];
                              return Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: CustomActivityLogCard(
                                  checkInModel: data,
                                  // title: "Fitness Heroes",
                                  // desc: "24/08/22 2:28 AM",
                                ),
                              );
                            },
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
