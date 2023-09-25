import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/bottom_sheet/filter_bottomsheet.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/explore_page.dart';
import 'package:fit_gate/screens/bottom_bar_screens/home_page.dart';
import 'package:fit_gate/screens/gym_details_screens/gym_details_screen.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_cards/custom_join_fit_card.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  int? index;
  final mapController = Get.put(MapController());
  final bottomController = Get.put(BottomController());

  getData() async {
    await mapController.getGym();
  }

  int? selectedIndex;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);

        return bottomController.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: AppBar(
              elevation: 4,
              shadowColor: MyColors.border.withOpacity(.30),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Explore",
                style: TextStyle(color: MyColors.black),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ImageButton(
                  onTap: () {
                    filterBottomSheet(context);
                  },
                  image: MyImages.filter,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<BottomController>(builder: (controller) {
                    return ImageButton(
                      image: MyImages.map,
                      onTap: () {
                        bottomController.setSelectedScreen(true,
                            screenName: ExplorePage());
                        Get.to(() => BottomNavigationScreen());
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 18),
            Text("Search Near by gyms",
                style: TextStyle(
                  fontSize: 17,
                )),
            SizedBox(height: 15),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    child: CustomGymCard(
                      onClick: () {
                        selectedIndex = 1;
                        setState(() {});
                        FocusManager.instance.primaryFocus?.unfocus();
                        mapController.getPackageListByName(packageName: "free");
                      },
                      img: MyImages.sapphire,
                      iconSize: 20,
                      selectedIndex: selectedIndex,
                      index: 1,
                      // width: MediaQuery.of(context).size.width * 0.28,
                      title: "Free",
                      titleClr: MyColors.blue,
                      boxShadow: BoxShadow(
                        color: MyColors.grey.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Expanded(
                    child: CustomGymCard(
                      onClick: () {
                        selectedIndex = 1;
                        setState(() {});
                        FocusManager.instance.primaryFocus?.unfocus();
                        mapController.getPackageListByName(packageName: "pro");
                      },

                      img: MyImages.emerald,
                      iconSize: 20,
                      selectedIndex: selectedIndex,
                      index: 1,
                      // width: MediaQuery.of(context).size.width * 0.28,
                      title: "Pro",
                      titleClr: MyColors.blue,
                      boxShadow: BoxShadow(
                        color: MyColors.grey.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: GetBuilder<MapController>(builder: (data) {
                  return ListView.builder(
                      itemCount: data.packageList.length,
                      itemBuilder: (c, i) {
                        var gymData = data.packageList[i];
                        return GetBuilder<BottomController>(
                            builder: (controller) {
                          return GymTile(
                            gymModel: gymData,
                            onClick: () {
                              index = i;
                              setState(() {});
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GymTile extends StatelessWidget {
  const GymTile({
    super.key,
    required this.gymModel,
    this.onClick,
    this.opening,
  });

  final GymDetailsModel gymModel;
  final VoidCallback? onClick;
  final String? opening;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.symmetric(horizontal: 15),
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: gymModel.sub_user_type == "pro"
                  ? MyColors.green.withOpacity(0.50)
                  : MyColors.border.withOpacity(.40),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.10),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                opening != null
                    ? SizedBox()
                    : Expanded(
                        // flex: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            placeholder: (c, url) => Center(
                              child: CircularProgressIndicator(
                                color: MyColors.orange,
                                strokeWidth: 2.5,
                              ),
                            ),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.12,
                            imageUrl:
                                "${EndPoints.imgBaseUrl}${gymModel.pictures?[0]}",
                            errorWidget: (c, u, r) => Container(),
                          ),
                        ),
                      ),
                SizedBox(width: opening != null ? 0 : 10),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${gymModel.facilityName}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: MyColors.orange,
                              size: 17,
                            ),
                            Text(
                              "${gymModel.rating ?? 0}",
                              style: TextStyle(
                                color: MyColors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              "${gymModel.review} Review",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: MyColors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: ImageButton(
                                padding: EdgeInsets.all(0),
                                image: opening != null
                                    ? MyImages.clock
                                    : MyImages.car,
                                color: MyColors.grey,
                                width: 13,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                opening ?? "22 Km",
                                style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 13.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${gymModel.sub_user_type}",
                      style: TextStyle(
                          color: gymModel.sub_user_type == "pro"
                              ? MyColors.green
                              : MyColors.brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
