import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/bottom_sheet/filter_bottomsheet.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/bottom_bar_screens/map_page.dart';
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
    // getData();
    super.initState();
  }

  @override
  void dispose() {
    // mapController.getAllGymList.value = [];
    super.dispose();
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
                    /*   showDialog(
                      context: context,
                      builder: (context) => FilterPage(),
                    );*/
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
                        bottomController.setSelectedScreen(true, screenName: MapPage());
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
            /*  SizedBox(height: 18),
            Text("Search Near by gyms",
                style: TextStyle(
                  fontSize: 17,
                )),
            SizedBox(height: 15),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomGymCard(
                        onClick: () {
                          selectedIndex = 1;
                          setState(() {});
                          FocusManager.instance.primaryFocus?.unfocus();
                          mapController.getFilterData(
                            subUserType: "free",
                          );
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
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomGymCard(
                        onClick: () {
                          selectedIndex = 1;
                          setState(() {});
                          FocusManager.instance.primaryFocus?.unfocus();
                          mapController.getFilterData(
                            subUserType: "pro",
                          );
                        },

                        img: MyImages.emerald,
                        iconSize: 20,
                        selectedIndex: selectedIndex,
                        index: 1,
                        // width: MediaQuery.of(context).size.width * 0.28,
                        title: "Pro",
                        titleClr: MyColors.green,
                        boxShadow: BoxShadow(
                          color: MyColors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ),
            ),*/
            // SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GetBuilder<MapController>(builder: (data) {
                  return data.getAllGymList.isEmpty
                      ? Center(child: Text("No data found"))
                      : ListView.builder(
                          itemCount: data.getAllGymList.length,
                          cacheExtent: 9999,
                          itemBuilder: (c, i) {
                            var gymData = data.getAllGymList[i];
                            return GetBuilder<BottomController>(builder: (controller) {
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

class GymTile extends StatefulWidget {
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
  State<GymTile> createState() => _GymTileState();
}

class _GymTileState extends State<GymTile> {
  final mapController = Get.put(MapController());
  @override
  void initState() {
    calculateDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
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
              color: widget.gymModel.sub_user_type == "pro"
                  ? MyColors.orange.withOpacity(0.50)
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.opening != null
                    ? SizedBox()
                    : Expanded(
                        // flex: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            placeholder: (c, url) => Center(
                              child: CircularProgressIndicator(
                                color: MyColors.orange,
                                strokeWidth: 1.5,
                              ),
                            ),
                            // Container(
                            //                               decoration: BoxDecoration(
                            //                                 image: DecorationImage(
                            //                                   image: CachedNetworkImageProvider(url),
                            //                                   fit: BoxFit.cover,
                            //                                 ),
                            //                               ),
                            //                             ),
                            placeholderFadeInDuration: Duration(seconds: 0),

                            useOldImageOnUrlChange: true,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.12,
                            imageUrl: "${EndPoints.imgBaseUrl}${widget.gymModel.pictures?[0]}",
                            errorWidget: (c, u, r) => Container(),
                          ),
                        ),
                      ),
                SizedBox(width: widget.opening != null ? 0 : 10),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.gymModel.facilityName}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        if (widget.gymModel.announcement != "")
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.orange,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(100))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                              child: Text(
                                "${widget.gymModel.announcement}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: MyColors.orange),
                              ),
                            ),
                          ),
                        SizedBox(height: 2),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: MyColors.orange,
                              size: 17,
                            ),
                            Text(
                              "${widget.gymModel.rating ?? 0}",
                              style: TextStyle(
                                color: MyColors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              "${widget.gymModel.review ?? 0} Review",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: MyColors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: ImageButton(
                                padding: EdgeInsets.all(0),
                                image: widget.opening != null ? MyImages.clock : MyImages.car,
                                color: MyColors.grey,
                                width: 13,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                widget.opening ??
                                    "${widget.gymModel.distance != null ? double.parse(widget.gymModel.distance.toString()).toStringAsFixed(2) : distance.toStringAsFixed(2)} km",
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
                  child: Text(
                    widget.gymModel.sub_user_type == "pro" ? "Pro" : "Free",
                    style: TextStyle(color: widget.gymModel.sub_user_type == "pro" ? MyColors.orange : MyColors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double distance = 0.0;

  String calculateDistance() {
    // double distance = 0.0;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((double.parse('${widget.gymModel.addressLatitude}') - mapController.latitude) * p) / 2 +
        c(mapController.latitude * p) *
            c(double.parse('${widget.gymModel.addressLatitude}') * p) *
            (1 - c((double.parse('${widget.gymModel.addressLongitude}') - mapController.longitude) * p)) /
            2;
    // return 12742 * asin(sqrt(a));
    distance = 12742 * asin(sqrt(a));
    return (distance).toStringAsFixed(2);
  }
}
