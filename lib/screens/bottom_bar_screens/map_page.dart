import 'dart:async';
import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/custom_widgets/custom_text_field.dart';
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'package:fit_gate/screens/explore.dart';
import 'package:fit_gate/screens/gym_details_screens/gym_details_screen.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/bottom_controller.dart';
import '../../custom_widgets/custom_google_map.dart';
import '../../utils/my_color.dart';

class MapPage extends StatefulWidget {
  final Function(int)? index;
  final bool? isExpPage;
  MapPage({Key? key, this.index, this.isExpPage}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = Get.put(MapController());
  final bottomController = Get.put(BottomController());
  TextEditingController search = TextEditingController();
  GoogleMapController? _googleMapController;
  CustomInfoWindowController infoWindowController = CustomInfoWindowController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> markers = {};
  List<MarkerList> list = [];
  String searchText = "";
  final scrollController = ScrollController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(24, 24)), "assets/pin.png").then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Future onMapCreated(GoogleMapController controller) async {
    await mapController.getLatLan();

    markers.clear();
    setState(() {
      for (int i = 0; i < mapController.latLngList.length; i++) {
        final marker = Marker(
          markerId: MarkerId("${mapController.latLngList[i].id}"),
          position: LatLng(double.parse(mapController.latLngList[i].addressLatitude!.toString()),
              double.parse(mapController.latLngList[i].addressLongitude!.toString())),
          //   icon: BitmapDescriptor.defaultMarker,
          icon: markerIcon,
          // infoWindow: InfoWindow(title: "", onTap: () {}),
          onTap: () {
            print("@@@@@@@@@@@@");
            infoWindowController.addInfoWindow!(
              GetBuilder<BottomController>(builder: (cont) {
                return GymTile(
                  gymModel: mapController.latLngList[i].gymDetailsModel!,

                  // img:
                  //     "${EndPoints.imgBaseUrl}${mapController.latLngList[i].gymDetailsModel?.pictures![0]}",
                  onClick: () {
                    cont.setSelectedScreen(
                      true,
                      screenName: GymDetailsScreen(
                        index: i,
                        gymDetailsModel: mapController.latLngList[i].gymDetailsModel,
                      ),
                    );
                    Get.to(() => BottomNavigationScreen());
                  },
                );
              }),
              LatLng(double.parse(mapController.latLngList[i].addressLatitude.toString()),
                  double.parse(mapController.latLngList[i].addressLongitude.toString())),
            );
          },
        );
        if (mapController.latLngList[i].gymDetailsModel!.status == "accept") markers.add(marker);
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

  Future goToPlace({required latitude, required longitude, id, name, index, GymDetailsModel? gymDetailsModel}) async {
    await _googleMapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(double.parse(latitude), double.parse(longitude)), 16));
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
          position: LatLng(double.parse(mapController.latLngList[i].addressLatitude!.toString()),
              double.parse(mapController.latLngList[i].addressLongitude!.toString())),
          icon: markerIcon,
          infoWindow: InfoWindow(title: "", onTap: () {}),
          onTap: () {
            print("@@@@@@@@@@@@11");
            infoWindowController.addInfoWindow!(
              GetBuilder<BottomController>(builder: (cont) {
                return GymTile(
                  gymModel: gymDetailsModel!,
                  // cardClr: MyColors.white,
                  // borderClr: Colors.transparent,
                  // title1: "738",
                  // rate: "4.5",
                  // img:
                  //     "${EndPoints.imgBaseUrl}${gymDetailsModel?.pictures![0]}",
                  onClick: () {
                    cont.setSelectedScreen(
                      true,
                      screenName: GymDetailsScreen(
                        index: index,
                        gymDetailsModel: gymDetailsModel,
                      ),
                    );
                    Get.to(() => BottomNavigationScreen());
                  },
                );
              }),
              LatLng(double.parse(latitude.toString()), double.parse(longitude.toString())),
            );
          },
        );
        markers.add(marker);
      }
    });
    // Get.to(() => GymMapDetailsPage(
    //       // markerId: MarkerId(id),
    //       // markers: markers,
    //       infoWindowController: infoWindowController,
    //       position: CameraPosition(
    //           target: LatLng(double.parse(latitude.toString()),
    //               double.parse(longitude.toString())),
    //           zoom: 16.0),
    //     ));
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
    getJsonFile("assets/map_style.json").then((value) => setMapStyle(value, mapController));
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
    addCustomIcon();
    onMapCreated;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getGymDetails();
    });
    header;
    print("((((((((((((((((((((((( ${markers}");
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
  Future getMapLatLng(GoogleMapController controller) async {
    await mapController.getLatLan();

    markers.clear();
    setState(() {
      for (int i = 0; i < mapController.latLngList.length; i++) {
        final marker = Marker(
          markerId: MarkerId("${mapController.latLngList[i].id}"),
          position: LatLng(double.parse(mapController.latLngList[i].addressLatitude!.toString()),
              double.parse(mapController.latLngList[i].addressLongitude!.toString())),
          icon: markerIcon,
          onTap: () {
            print("@@@@@@@@@@@@44");
            infoWindowController.addInfoWindow!(
              GetBuilder<BottomController>(builder: (cont) {
                return GymTile(
                  gymModel: mapController.latLngList[i].gymDetailsModel!,
                  // cardClr: MyColors.white,
                  // borderClr: Colors.transparent,
                  // title1: "738",
                  // rate: "4.5",
                  // img:
                  //     "${EndPoints.imgBaseUrl}${mapController.latLngList[i].gymDetailsModel?.pictures![0]}",
                  onClick: () {
                    cont.setSelectedScreen(
                      true,
                      screenName: GymDetailsScreen(
                        index: i,
                        gymDetailsModel: mapController.latLngList[i].gymDetailsModel,
                      ),
                    );
                    Get.to(() => BottomNavigationScreen());
                  },
                );
              }),
              LatLng(double.parse(mapController.latLngList[i].addressLatitude.toString()),
                  double.parse(mapController.latLngList[i].addressLongitude.toString())),
            );
          },
        );
        markers.add(marker);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    header;
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(0);

        return bottomController.setSelectedScreen(true, screenName: Explore());
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.blue.withOpacity(.40),
        extendBody: true,
        key: homeScaffoldKey,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(kToolbarHeight),
        //   child: GestureDetector(
        //     onTap: () {
        //       search.clear();
        //       setState(() {});
        //       FocusManager.instance.primaryFocus?.unfocus();
        //     },
        //     child: CustomAppBar(
        //       title: "Explore",
        //       leadingImage: "",
        //       // actionIcon: Icons.add,
        //       fontWeight: FontWeight.w900,
        //       onTap: () {
        //         search.clear();
        //         setState(() {});
        //       },
        //     ),
        //   ),
        // ),
        body: GetBuilder<MapController>(builder: (cont) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  search.clear();
                  setState(() {});
                },
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = controller;
                    changeMapMode(_googleMapController!);
                    onMapCreated(_googleMapController!);
                    print("GOOGLE MAP CONTROLLER -------> $_googleMapController");
                    // getMapLatLng(_googleMapController!);
                    infoWindowController.googleMapController = controller;
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

                  zoomControlsEnabled: true,
                  buildingsEnabled: true,

                  onCameraMove: (val) {
                    infoWindowController.hideInfoWindow!();
                  },
                ),
              ),
              CustomInfoWindow(
                controller: infoWindowController,
                width: 380,
                height: 140,
                // offset: 35,26.13375693911818, 50.582237085047154
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 45),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GetBuilder<BottomController>(builder: (bottomController) {
                              return GestureDetector(
                                onTap: () {
                                  search.clear();
                                  bottomController.setSelectedScreen(true, screenName: Explore());
                                  Get.to(() => BottomNavigationScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(17.0),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 20,
                                      color: MyColors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(width: 0),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15),
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
                                    print("00000000 $searchText");
                                  },
                                ),
                                onFocusChange: (val) {
                                  if (!val) {
                                    search.clear();
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: .0, left: 15, right: 15),
                        child: search.text.isEmpty
                            ? SizedBox()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: mapController.searchList.length,
                                itemBuilder: (c, i) {
                                  var a = mapController.searchList[i];
                                  return GestureDetector(
                                    onTap: () {
                                      searchText.isEmpty
                                          ? SizedBox()
                                          : goToPlace(
                                              id: a.id.toString(),
                                              index: i,
                                              name: a.addressAddress,
                                              latitude: a.addressLatitude,
                                              longitude: a.addressLongitude,
                                              gymDetailsModel: a);
                                      search.clear();
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                                        child: Text("${a.facilityName}"),
                                      ),
                                    ),
                                  );
                                }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
