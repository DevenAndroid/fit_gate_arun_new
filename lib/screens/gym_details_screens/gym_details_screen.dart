// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/controller/bottom_controller.dart';
import 'package:fit_gate/custom_widgets/custom_google_map.dart';
import 'package:fit_gate/screens/explore.dart';
import 'package:fit_gate/screens/gym_details_screens/photo_view_page.dart';
import 'package:fit_gate/screens/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/my_color.dart';
import '../../controller/map_controller.dart';
import '../../controller/notification_controller.dart';
import '../../custom_widgets/custom_btns/custom_button.dart';
import '../../custom_widgets/custom_btns/icon_button.dart';
import '../../models/gym_details_model.dart';
import '../../utils/end_points.dart';
import '../../utils/my_images.dart';
import '../notification_page.dart';

class GymDetailsScreen extends StatefulWidget {
  final GymDetailsModel? gymDetailsModel;
  final int? index;
  const GymDetailsScreen({Key? key, this.gymDetailsModel, this.index}) : super(key: key);

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  int chooseOption = 0;
  final bottomController = Get.put(BottomController());
  final mapController = Get.put(MapController());

  GoogleMapController? _googleMapController;
  List<MarkerList> markers = [];
  var uuid = const Uuid();

  Position? position;
  Future getLocation() async {
    print("CURRENT LOCATION");
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print("POSITIONNNNNN --------------       ${position}");
    return position;
  }

  getGymDetails() async {
    await mapController.getGym();
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(44, 44)), "assets/pin.png").then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Future goToPlace() async {
    await _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(double.parse(widget.gymDetailsModel!.addressLatitude.toString()),
            double.parse(widget.gymDetailsModel!.addressLongitude.toString())),
        zoom: 16.0)));
    setState(() {
      markers.add(MarkerList(
        Marker(
          markerId: MarkerId("id"),
          icon: markerIcon,
          infoWindow: InfoWindow(title: widget.gymDetailsModel?.addressAddress),
          position: LatLng(double.parse(widget.gymDetailsModel!.addressLatitude.toString()),
              double.parse(widget.gymDetailsModel!.addressLongitude.toString())),
        ),
      ));
    });
  }

  //format time in am / pm
  String formatTimeOfDay(TimeOfDay selectedTime) {
    DateTime tempDate = DateFormat.Hms()
        .parse(selectedTime.hour.toString() + ":" + selectedTime.minute.toString() + ":" + '0' + ":" + '0');
    var dateFormat = DateFormat("h:mm a");
    return (dateFormat.format(tempDate));
  }

  //show working hours
  var weekDay;
  getDailyDate() {
    DateTime dateTime = DateTime.now();
    weekDay = dateTime.weekday;
  }

  @override
  void initState() {
    addCustomIcon();
    getGymDetails();
    mapController.getLocation1();
    goToPlace();
    getDailyDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var details = widget.gymDetailsModel!;
    return WillPopScope(
      onWillPop: () {
        bottomController.getIndex(1);

        return bottomController.setSelectedScreen(true, screenName: Explore());
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MyImages.wild),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      // bottom: PreferredSize(
                      //     child: CheckConnection(),
                      //     preferredSize: Size.fromHeight(70)),
                      title: Text(
                        "Gym Details",
                        style: TextStyle(color: MyColors.white),
                      ),
                      leadingWidth: 45,
                      leading: GestureDetector(
                          onTap: () {
                            print("object");
                            bottomController.setSelectedScreen(true, screenName: Explore());
                            // Get.to(() => BottomNavigationScreen());
                            // context.go('/page2');
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Image.asset(
                              MyImages.arrowLeft,
                              color: MyColors.white,
                              height: 18,
                              width: 18,
                            ),
                            /*ImageButton(
                        padding: EdgeInsets.only(
                            left: 20, top: 18, bottom: 11, right: 17),
                        image: widget.leadingImage ?? MyImages.arrowBack,
                        height: 20,
                        width: 20,
                        color: widget.leadingImageClr ?? MyColors.black,
                      ),*/
                          )),
                      actions: [
                        GetBuilder<NotificationController>(builder: (cont) {
                          return GestureDetector(
                            onTap: () async {
                              Get.to(() => NotificationPage());
                            },
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0, top: 18, left: 20, bottom: 11),
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.notifications_none,
                                      size: 25,
                                      color: MyColors.white,
                                    ),
                                    cont.notifyCount == true
                                        ? Positioned(
                                            right: 0,
                                            child: Container(
                                              height: 8,
                                              width: 9,
                                              decoration: BoxDecoration(
                                                color: MyColors.orange,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                // : Icon(
                                //     Icons.notifications_none,
                                //     size: 25,
                                //     color: MyColors.grey,
                                //   ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (c, url) => Center(
                          child: CircularProgressIndicator(
                            color: MyColors.orange,
                            strokeWidth: 2.5,
                          ),
                        ),
                        imageUrl: "${EndPoints.imgBaseUrl}${details.logo.toString()}",
                        errorWidget: (c, u, r) => Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GymTile(
                  gymModel: widget.gymDetailsModel!,
                  // cardClr: MyColors.white,
                  // borderClr: Colors.transparent,
                  // title1: "738",
                  opening:
                      "Opening ${widget.gymDetailsModel?.workingHour?[weekDay - 1].start} To ${widget.gymDetailsModel?.workingHour?[weekDay - 1].end}",
                  // rate: "4.5",
                  // clockImg: MyImages.clock,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.41,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Text(
                        "Gym Photos",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            cacheExtent: 9999,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: details.pictures?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => PhotoViewPage(
                                          gymDetailsModel: details,
                                          index: index,
                                        ));
                                  },
                                  child: CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (c, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: MyColors.orange,
                                      ),
                                    ),
                                    imageUrl: "${EndPoints.imgBaseUrl}${details.pictures?[index]}",
                                    errorWidget: (c, u, r) => Container(),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Gym Details",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('PHONE CLICK');
                              launchUrl(Uri.parse("tel:+${details.phoneNumber}"));
                            },
                            child: Row(
                              children: [
                                ImageButton(
                                  image: MyImages.phone,
                                  height: 15,
                                  width: 15,
                                ),
                                Text(
                                  '${details.phoneNumber}',
                                  style: TextStyle(
                                    color: MyColors.blue,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                            child: Text("${details.about ?? 'No details available'}"),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Working Hours",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(height: 5),
                              ImageButton(
                                // padding: EdgeInsets.all(0),
                                image: MyImages.clock,
                                color: MyColors.grey,
                                height: 18,
                                width: 18,
                              ),
                            ],
                          )),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Days",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Open",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Close",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                // SizedBox(height: 7),
                                // Text("${details.workingHour![0].day}"),
                                ListView.builder(
                                    cacheExtent: 9999,
                                    itemCount: details.workingHour?.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    //   crossAxisCount: 3,
                                    // ),
                                    itemBuilder: (c, i) {
                                      return Table(
                                        // border: TableBorder.all(
                                        //   width: 0.9,
                                        //   color: MyColors.grey,
                                        // ),
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${details.workingHour![i].day![0].toUpperCase()}${details.workingHour![i].day?.substring(1)}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColors.orange,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("${details.workingHour![i].start}"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("${details.workingHour![i].end}"),
                                            ),
                                          ]),
                                        ],
                                      );
                                    }),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Amenities",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: details.amenities?.length,
                        itemBuilder: (context, index) {
                          return CustomRowText(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: MyColors.orange),
                            color: MyColors.white,
                            checkColor: MyColors.orange,
                            title: details.amenities![index],
                          );
                        },
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 1.9),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Gym Location",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              zoom: 16,
                              target: LatLng(double.parse(details.addressLatitude.toString()),
                                  double.parse(details.addressLongitude.toString())),
                            ),
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            buildingsEnabled: true,
                            markers: markers.map((e) => e.marker).toSet(),
                            onTap: (latLag) {
                              /* setState(() {
                                // latlong = latLag;
                                if (markers.isEmpty) {
                                  final id = uuid.v4();
                                  print("UUID IDDDD ${id}");
                                  markers.add(MarkerList(
                                    Marker(
                                      markerId: MarkerId(id),
                                      infoWindow: InfoWindow(
                                        title: details.addressAddress,
                                      ),
                                      icon: BitmapDescriptor.defaultMarker,
                                      position: latLag,
                                    ),
                                  ));
                                }
                              });*/
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _googleMapController = controller;
                              // _controller.complete(controller);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GetBuilder<BottomController>(builder: (cont) {
                        return CustomButton(
                          onTap: () async {
                            var lat = widget.gymDetailsModel!.addressLatitude;
                            var lng = widget.gymDetailsModel!.addressLongitude;
                            /*var url =
                                // 'https://www.google.com/maps/dir/${position?.latitude},${position?.longitude}/${widget.gymDetailsModel?.addressAddress!.replaceAll(',', '+')}/@${lat},$lng,1d$lng!2d$lat!1d$lng!2d$lat';
                                // 'https://www.google.com/maps/dir/My%20Location/${widget.gymDetailsModel?.addressAddress!.replaceAll(',', '+')}/@${lat},$lng,1d$lng!2d$lat!1d$lng!2d$lat';
                                 'https://www.google.com/maps/dir/current%20location/Hatkeshwar';*/
                            var url = 'https://maps.google.com/?saddr=My%20Location&daddr=$lat,$lng';
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => launchWebView(url)));*/
                            launchUrl(Uri.parse(url));
                            // launchMap();
                            // bottomController.setSelectedScreen(true,
                            //     screenName: SubscriptionPage());
                            // await mapController.launchMap(
                            //     widget.gymDetailsModel!.addressLatitude,
                            //     widget.gymDetailsModel!.addressLongitude,
                            //     widget.gymDetailsModel?.addressAddress);
                          },
                          height: MediaQuery.of(context).size.height * 0.06,
                          title: "Navigate",
                          fontSize: 18,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        /* floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.orange,
          onPressed: () async {
            print("!!!  ${widget.gymDetailsModel!.addressLatitude}");
            print("### ${widget.gymDetailsModel!.addressLongitude}");
            await mapController.launchMap(
                widget.gymDetailsModel!.addressLatitude,
                widget.gymDetailsModel!.addressLongitude,
                widget.gymDetailsModel?.addressAddress);
          },
          child: Icon(Icons.directions),
        ),*/
      ),
    );
  }
//'https://www.google.com/maps/dir/${position?.latitude},${position?.longitude}/${widget.gymDetailsModel?.addressAddress!.replaceAll(',', '+')}/@${lat},$lng,1d$lng!2d$lat!1d$lng!2d$lat'

  /* Widget launchMap() {
    var lat = widget.gymDetailsModel!.addressLatitude;
    var lng = widget.gymDetailsModel!.addressLongitude;
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse());
    return Scaffold(
        body: SafeArea(
      child: WebViewWidget(
        controller: controller,
      ),
    ));
  }*/
}
