import 'dart:async';
import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/screens/bottom_bar_screens/home_page.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/bottom_controller.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_cards/custom_explore_card.dart';
import '../../custom_widgets/custom_cards/custom_join_fit_card.dart';
import '../../custom_widgets/custom_google_map.dart';
import '../../utils/my_color.dart';
import '../gym_details_screens/gym_details_screen.dart';
import '../gym_map_details_page.dart';
import 'bottom_naviagtion_screen.dart';

class ExplorePage extends StatefulWidget {
  final Function(int)? index;
  final bool? isExpPage;
  ExplorePage({Key? key, this.index, this.isExpPage}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final mapController = Get.put(MapController());
  final bottomController = Get.put(BottomController());
  TextEditingController search = TextEditingController();
  GoogleMapController? _googleMapController;
  CustomInfoWindowController infoWindowController =
      CustomInfoWindowController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> markers = {};
  List<MarkerList> list = [];
  String searchText = "";
  final scrollController = ScrollController();

  Future onMapCreated(GoogleMapController controller) async {
    await mapController.getLatLan();

    markers.clear();
    setState(() {
      for (int i = 0; i < mapController.latLngList.length; i++) {
        final marker = Marker(
          markerId: MarkerId("${mapController.latLngList[i].id}"),
          position: LatLng(
              double.parse(
                  mapController.latLngList[i].addressLatitude!.toString()),
              double.parse(
                  mapController.latLngList[i].addressLongitude!.toString())),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "", onTap: () {}),
          onTap: () async {
            goToPlace(
                index: i,
                id: mapController.latLngList[i].id.toString(),
                name: mapController.latLngList[i].facilityName,
                latitude: mapController.latLngList[i].addressLatitude,
                longitude: mapController.latLngList[i].addressLongitude,
                gymDetailsModel: mapController.latLngList[i].gymDetailsModel);
          },
        );
        if (mapController.latLngList[i].gymDetailsModel!.status == "accept")
          markers.add(marker);
      }
    });
  }

  // Position? position;
  // Future getLocation() async {
  //   print("CURRENT LOCATION");
  //   position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   print("POSITIONNNNNN --------------       ${position}");
  //
  //   return position;
  // }

  Future goToPlace(
      {required latitude,
      required longitude,
      id,
      name,
      index,
      GymDetailsModel? gymDetailsModel}) async {
    await _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(double.parse(latitude), double.parse(longitude)), 16));
    // setState(() {
    //   var marker = MarkerList(Marker(
    //     markerId: MarkerId(id),
    //     onTap: () {
    //       infoWindowController.addInfoWindow!(
    //         GetBuilder<BottomController>(builder: (cont) {
    //           return CustomExploreCard(
    //             gymDetailsModel: gymDetailsModel,
    //             cardClr: MyColors.white,
    //             borderClr: Colors.transparent,
    //             title1: "738 Reviews",
    //             title2: "2 km",
    //             rate: "4.5",
    //             img: "${EndPoints.imgBaseUrl}${gymDetailsModel?.pictures![0]}",
    //             onClick: () {
    //               cont.setSelectedScreen(
    //                 true,
    //                 screenName: GymDetailsScreen(
    //                   index: index,
    //                   gymDetailsModel: gymDetailsModel,
    //                 ),
    //               );
    //               Get.to(() => BottomNavigationScreen());
    //             },
    //           );
    //         }),
    //         LatLng(double.parse(latitude.toString()),
    //             double.parse(longitude.toString())),
    //       );
    //     },
    //     position: LatLng(double.parse(latitude.toString()),
    //         double.parse(longitude.toString())),
    //   ));
    //
    //   list..add(marker);
    //   markers.add(
    //     Marker(
    //       markerId: MarkerId(id),
    //       infoWindow: InfoWindow(title: name),
    //       position: LatLng(double.parse(latitude.toString()),
    //           double.parse(longitude.toString())),
    //     ),
    //   );
    // });
    await mapController.getLatLan();

    markers.clear();
    setState(() {
      for (int i = 0; i < mapController.latLngList.length; i++) {
        final marker = Marker(
          markerId: MarkerId("${mapController.latLngList[i].id}"),
          position: LatLng(
              double.parse(
                  mapController.latLngList[i].addressLatitude!.toString()),
              double.parse(
                  mapController.latLngList[i].addressLongitude!.toString())),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "", onTap: () {}),
          onTap: () async {
            goToPlace(
              index: i,
              id: mapController.latLngList[i].id.toString(),
              name: mapController.latLngList[i].facilityName,
              latitude: mapController.latLngList[i].addressLatitude,
              longitude: mapController.latLngList[i].addressLongitude,
              gymDetailsModel: mapController.latLngList[i].gymDetailsModel,
            );
          },
        );
        markers.add(marker);
      }
    });
    Get.to(() => GymMapDetailsPage(
          // markerId: MarkerId(id),
          // markers: markers,
          infoWindowController: infoWindowController,
          position: CameraPosition(
              target: LatLng(double.parse(latitude.toString()),
                  double.parse(longitude.toString())),
              zoom: 16.0),
        ));
    setState(() {});
    print("qqqqqqq $longitude");
    print("aaaaaaa $latitude");
  }

  getGymDetails() async {
    await mapController.getCurrentLocation();
    print("mapController.permission${mapController.permission}");
    // await _determinePosition();
    // await gymController.getPackageListByName(
    //     lat: position?.longitude, lon: position?.longitude);
    await mapController.getGym();
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/map_style.json")
        .then((value) => setMapStyle(value, mapController));
  }

  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  Future<String> getJsonFile(String path) async {
    var byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  int selectedIndex = 0;
  @override
  void initState() {
    onMapCreated;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getGymDetails();
    });
    header;
    // getLocation();
    super.initState();
  }

  @override
  void dispose() {
    snackbarKey.currentState?.hideCurrentSnackBar();
    super.dispose();
  }
  // @override
  // void dispose() {
  //   if (_googleMapController != null) {
  //     _googleMapController!.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    header;
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);

        return bottomController.setSelectedScreen(true, screenName: HomePage());
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        extendBody: true,
        key: homeScaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: GestureDetector(
            onTap: () {
              search.clear();
              setState(() {});
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CustomAppBar(
              title: "Explore",
              leadingImage: "",
              // actionIcon: Icons.add,
              fontWeight: FontWeight.w900,
              onTap: () {
                search.clear();
                setState(() {});
              },
            ),
          ),
        ),
        body: RefreshIndicator(
          color: MyColors.orange,
          onRefresh: () async {
            print('dsfsfs');
            await mapController.getGym();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Column(
              children: [
                GetBuilder<MapController>(builder: (mapController) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: GoogleMap(
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController = controller;
                            changeMapMode(_googleMapController!);
                            onMapCreated(_googleMapController!);
                            setState(() {});
                            // Uuid id = Uuid();
                            // controller.showMarkerInfoWindow(MarkerId("$id"));
                          },
                          // Bahrain
                          initialCameraPosition: CameraPosition(
                            target: Global.userModel?.countryName == "Bahrain"
                                ? LatLng(26.126532866, 50.58895572)
                                : LatLng(26.2172, 50.1971),
                            zoom: 13.2,
                          ),
                          markers: markers,
                          onTap: (vd) {
                            search.clear();
                            setState(() {});
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                      /* Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, riguht: 15, top: 15),
                        child: Focus(
                          child: CustomTextField(
                              controller: search,
                            prefixIcon: MyImages.search,
                            hint: "Search",
                            color: MyColors.white,
                            fillColor: MyColors.white,
                            onChanged: (val) {
                              setState(() {
                                searchText = val;
                              });
                              mapController.getLocation(search: searchText);
                              print("search LIst ----------  ${searchText}");
                            },
                          ),
                          onFocusChange: (value) {
                            if (!value) {
                              // snackBar(value.toString());
                              search.clear();
                              setState(() {});
                            }
                          },
                        ),
                      ),*/
                      /*  Padding(
                        padding: const EdgeInsets.only(
                            top: 70.0, left: 15, right: 15),
                        child: mapController.searchList.isEmpty
                            ? search.text.isEmpty
                                ? Text("")
                                : Center(
                                    child: Card(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No data found"),
                                    )),
                                  )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: mapController.searchList.length,
                                itemBuilder: (c, i) {
                                  var a = mapController.searchList[i];
                                  return GestureDetector(
                                    onTap: () {
                                      goToPlace(
                                          index: i,
                                          id: a.id.toString(),
                                          name: a.addressAddress,
                                          latitude: a.addressLatitude,
                                          longitude: a.addressLongitude,
                                          gymDetailsModel: a);
                                    },
                                    child: search.text.isEmpty
                                        ? SizedBox()
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: MyColors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("${a.addressAddress}"),
                                                  SizedBox(height: 5)
                                                  // Divider()
                                                ],
                                              ),
                                            )),
                                  );
                                }),
                      ),
                      mapController.searchList.isEmpty ||
                              mapController.paginationData.totalRows == null ||
                              mapController.paginationData.totalRows! <= 10
                          ? SizedBox()
                          : Positioned(
                              top: MediaQuery.of(context).size.height * 0.3,
                              left: 20,
                              child: AllPaginationWidget(
                                searchGym: mapController,
                                s: search.text,
                              ),
                            )*/
                    ],
                  );
                }),
                SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Text(
                        //   "Search nearby gyms",
                        //   style: TextStyle(
                        //     color: MyColors.black,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        SizedBox(height: 5),
                        GetBuilder<MapController>(builder: (cont) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, right: 3),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomGymCard(
                                      onClick: () {
                                        selectedIndex = 1;
                                        setState(() {});
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        mapController.getPackageListByName(
                                            packageName: "sapphire");
                                      },
                                      img: MyImages.sapphire,
                                      iconSize: 20,
                                      selectedIndex: selectedIndex,
                                      index: 1,
                                      // width: MediaQuery.of(context).size.width * 0.28,
                                      title: "Sapphire",
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
                                        selectedIndex = 2;
                                        setState(() {});
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        mapController.getPackageListByName(
                                            packageName: "emerald");
                                      },
                                      img: MyImages.emerald,
                                      iconSize: 20,
                                      selectedIndex: selectedIndex,
                                      index: 2,
                                      // width: MediaQuery.of(context).size.width * 0.28,
                                      title: "Emerald",
                                      titleClr: MyColors.green,
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
                                        selectedIndex = 3;
                                        setState(() {});
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        mapController.getPackageListByName(
                                            packageName: "ruby");
                                      },
                                      img: MyImages.ruby,
                                      iconSize: 20,
                                      index: 3,
                                      selectedIndex: selectedIndex,
                                      // width: MediaQuery.of(context).size.width * 0.28,
                                      title: "  Ruby",
                                      titleClr: MyColors.brown,
                                      boxShadow: BoxShadow(
                                        color: MyColors.grey.withOpacity(0.25),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                        GetBuilder<MapController>(builder: (controllers) {
                          return controllers.packageList.isEmpty
                              ? Text("No gym found")
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Scrollbar(
                                    thickness: 5.0,
                                    thumbVisibility: true,
                                    controller: scrollController,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        itemCount:
                                            controllers.packageList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4),
                                            child: GetBuilder<BottomController>(
                                              builder: (controller) =>
                                                  CustomExploreCard(
                                                onClick: () {
                                                  controller.setSelectedScreen(
                                                    true,
                                                    screenName:
                                                        GymDetailsScreen(
                                                      index: index,
                                                      gymDetailsModel:
                                                          controllers
                                                                  .packageList[
                                                              index],
                                                    ),
                                                  );
                                                  Get.to(() =>
                                                      BottomNavigationScreen());
                                                },
                                                gymDetailsModel: controllers
                                                    .packageList[index],
                                                cardClr: MyColors.white,
                                                borderClr: Colors.transparent,
                                                title1: "250",
                                                rate: "4.5",
                                                img:
                                                    "${EndPoints.imgBaseUrl}${controllers.packageList[index].pictures?[0]}",
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                        }),
                      ],
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
