// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../controller/map_controller.dart';
import '../custom_widgets/custom_cards/custom_explore_card.dart';
import '../custom_widgets/custom_text_field.dart';
import '../utils/end_points.dart';
import '../utils/my_color.dart';
import 'bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'gym_details_screens/gym_details_screen.dart';

class GymMapDetailsPage extends StatefulWidget {
  final CameraPosition? position;
  final Set<Marker>? markers;
  final CustomInfoWindowController? infoWindowController;
  final MarkerId? markerId;

  GymMapDetailsPage(
      {Key? key,
      this.position,
      this.markers,
      this.infoWindowController,
      this.markerId})
      : super(key: key);

  @override
  State<GymMapDetailsPage> createState() => _GymMapDetailsPageState();
}

class _GymMapDetailsPageState extends State<GymMapDetailsPage> {
  var uuid = const Uuid();
  TextEditingController search = TextEditingController();
  GoogleMapController? _googleMapController;
  final mapController = Get.put(MapController());
  Set<Marker> markers = {};
  String searchText = "";

  Future getMapLatLng(GoogleMapController controller) async {
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
          onTap: () {
            print("@@@@@@@@@@@@44");
            widget.infoWindowController!.addInfoWindow!(
              GetBuilder<BottomController>(builder: (cont) {
                return CustomExploreCard(
                  gymDetailsModel: mapController.latLngList[i].gymDetailsModel,
                  cardClr: MyColors.white,
                  borderClr: Colors.transparent,
                  title1: "738",
                  rate: "4.5",
                  img:
                      "${EndPoints.imgBaseUrl}${mapController.latLngList[i].gymDetailsModel?.pictures![0]}",
                  onClick: () {
                    cont.setSelectedScreen(
                      true,
                      screenName: GymDetailsScreen(
                        index: i,
                        gymDetailsModel:
                            mapController.latLngList[i].gymDetailsModel,
                      ),
                    );
                    Get.to(() => BottomNavigationScreen());
                  },
                );
              }),
              LatLng(
                  double.parse(
                      mapController.latLngList[i].addressLatitude.toString()),
                  double.parse(
                      mapController.latLngList[i].addressLongitude.toString())),
            );
          },
        );
        markers.add(marker);
      }
    });
  }

  Future goToPlace(
      {required latitude,
      required longitude,
      id,
      name,
      index,
      GymDetailsModel? gymDetailsModel}) async {
    await _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(double.parse(latitude.toString()),
            double.parse(longitude.toString())),
        17));
    setState(() {
      var marker = Marker(
        markerId: MarkerId(id),
        onTap: () {
          print("@@@@@@@@@@@@11");
          widget.infoWindowController!.addInfoWindow!(
            GetBuilder<BottomController>(builder: (cont) {
              return CustomExploreCard(
                gymDetailsModel: gymDetailsModel,
                cardClr: MyColors.white,
                borderClr: Colors.transparent,
                title1: "738",
                rate: "4.5",
                img: "${EndPoints.imgBaseUrl}${gymDetailsModel?.pictures![0]}",
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
            LatLng(double.parse(latitude.toString()),
                double.parse(longitude.toString())),
          );
        },
        position: LatLng(double.parse(latitude.toString()),
            double.parse(longitude.toString())),
      );
      markers.add(marker);
    });

    print("MARKER LIST --------------- ${widget.markers?.length}");
    print("qqqqqqq $longitude");
    print("aaaaaaa $latitude");
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/map_style.json")
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    var byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  getData() async {
    // await mapController.getLatLan();
    await mapController.getGym();
    await mapController.getLatLan();
  }

  @override
  void initState() {
    getMapLatLng;
    getData();
    print('ffffffffffffffff');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder<MapController>(builder: (cont) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                search.clear();
                setState(() {});
              },
              child: GoogleMap(
                initialCameraPosition: widget.position!,
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
                buildingsEnabled: true,
                markers: markers.toSet(),
                onTap: (vd) {
                  search.clear();
                  setState(() {});
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onCameraMove: (val) {
                  widget.infoWindowController?.hideInfoWindow!();
                },
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController = controller;
                  print("GOOGLE MAP CONTROLLER -------> $_googleMapController");
                  getMapLatLng(_googleMapController!);
                  changeMapMode(_googleMapController!);
                  widget.infoWindowController?.googleMapController = controller;
                  // _googleMapController?.showMarkerInfoWindow(widget.markerId!);

                  // Uuid id = Uuid();
                  // controller.showMarkerInfoWindow(MarkerId("$id"));
                },
              ),
            ),
            CustomInfoWindow(
              controller: widget.infoWindowController!,
              width: 350,
              height: 120,
              // offset: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              search.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: MyColors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
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
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 15, right: 15),
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
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${a.addressAddress}"),
                                          SizedBox(height: 5)
                                          // Divider()
                                        ],
                                      ),
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
    ));
  }
}
