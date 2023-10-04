import 'dart:convert';
import 'dart:developer';

import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/models/gym_details_model.dart';
import 'package:fit_gate/models/latlag_model.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../models/pagination_model.dart';

class MapController extends GetxController {
  var latLngList = <LatLngModel>[].obs;
  var searchList = <GymDetailsModel>[].obs;
  String googleApiKey = 'AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI';
  late GoogleMapController googleMapController;
  String? searchValue;
  int nextPage = 1;
  // bool isFilter = false;
  // var packageList = <GymDetailsModel>[].obs;
  var getAllGymList = <GymDetailsModel>[].obs;
  var nearbyGymList = <GymDetailsModel>[].obs;

  PaginationDataModel paginationData = PaginationDataModel();
  bool loadingValue = false;
  // bool hasData = false;
  String getJson(jsonObject, {name}) {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future getFilterData({
    String? packageName,
    String? subUserType,
    String? distance,
    String? amenities,
    String? lat,
    String? lon,
    bool isCurrentLocation = false,
  }) async {
    loadingValue = true;
    update();
    // loading(value: true);
    var data = {
      "class_type": "",
      "sub_user_type": subUserType ?? "",
      "distance": distance ?? "",
      "amenities": amenities ?? "",
      "lat": isCurrentLocation ? lat : latitude,
      "lon": isCurrentLocation ? lon : longitude,
    };
    // Future.delayed(
    //   Duration(seconds: 2),
    //   () async {
    http.Response response =
        await http.post(Uri.parse(EndPoints.classTypeFilterGym), headers: await header, body: jsonEncode(data));
    log("class type request : " + jsonEncode(data));
    print("ENCODED ${jsonEncode(data)}");
    print("RESPONSE" + response.body);
    log("class type response : " + response.body);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      loadingValue = false;
      update();
      var list = (parsedData['data'] as List).map((e) => GymDetailsModel.fromJson(e)).toList();
      // parsedData['data'] != [] ? hasData = true : hasData = false;
      if (isCurrentLocation) {
        nearbyGymList.value = list;
      } else {
        getAllGymList.value = list;
      }

      update();
    } else {
      loadingValue = false;
      getAllGymList.value = [];
      nearbyGymList.value = [];
      update();
    }
    //   },
    // );
  }

  getGym() async {
    // loadingValue = true;
    print("PARSED DATA ------------  222222222222 ${EndPoints.getGym + "?user_id=${Global.userModel?.id}"}");
    http.Response response = await http.get(
      Uri.parse(EndPoints.getGym + "?user_id=${Global.userModel?.id}"),
      headers: await header,
    );
    var parsedData = jsonDecode(response.body);
    print("PARSED DATA ------------  111111111111 $parsedData");
    print("gggggg....      " + response.body);
    log(response.body);
    if (parsedData['statusCode'] == 200) {
      // loadingValue = false;
      var list = (parsedData['data'] as List).map((e) => GymDetailsModel.fromJson(e)).toList();
      getAllGymList.value = list;
      update();
    } else {
      // loadingValue = false;
      getAllGymList.value = [];
      update();
    }
  }

  getLocation({String? search}) async {
    var data = {"page_no": nextPage, "search": search ?? ""};
    var response = await http.post(Uri.parse(EndPoints.searchGym), headers: await header, body: jsonEncode(data));
    var parsedData = jsonDecode(response.body);

    if (parsedData['status'] == 200) {
      var list = (parsedData['data'] as List).map((e) => GymDetailsModel.fromJson(e)).toList();

      paginationData = PaginationDataModel.fromJson(parsedData['paginate_data']);
      print("PAGINATION DATA -----------     $paginationData");
      update();
      return searchList.value = list;
    } else if (parsedData['statusCode'] == 401) {
      showToast(parsedData['error']);
    }
  }

  Position? position;
  Future getLocation1() async {
    print("CURRENT LOCATION");
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print("POSITIONNNNNN --------------       ${position}");

    return position;
  }

  getLatLan() async {
    // loading(value: true);
    var response = await http.get(
      Uri.parse(EndPoints.getLatLan),
      headers: await header,
    );
    var data = jsonDecode(response.body);

    // loading(value: false);
    print("LOCATION  DATA ------------- $data");
    if (data['statusCode'] == 200) {
      print("MAP DATA ========++++++++++++++++ |||||||||||||||||  ${data['data']}");

      var list = (data['data'] as List).map((e) => LatLngModel.fromJson(e)).toList();
      print("LIST ----############ $list");
      update();
      return latLngList.value = list;
    }
    return position;
  }

  // launchMap(lat, lng, title) async {
  //   //'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  //   // String googleUrl =
  //   //     'https://www.google.com/maps/dir/$lat,$lng/$title/=$lat,$lng';
  //   // print("$googleUrl");
  //   String googleUrl =
  //       'https://www.google.com/maps/dir/${26.20654859365006},${50.533008485715904}/@$lat,$lng,14z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x395e9b087c377e8f:0xe08175d5c9bd0735!2m2!1d72.6700859!2d23.0151166';
  //   print("URL ===   $googleUrl");
  //   await launchUrl(Uri.parse(googleUrl));
  //   // return googleUrl;
  //   // MapsLauncher.launchCoordinates(
  //   //     double.parse(lat), double.parse(long), title);
  //   // final availableMaps = await MapLauncher.installedMaps;
  //   // for (var map in availableMaps) {
  //   //   await map.showMarker(
  //   //       coords: Coords(double.parse(lat), double.parse(long)),
  //   //       title: title,
  //   //       description: title,
  //   //       zoom: 15);
  //   // }
  // }

  launchMap(lat, lng, String? title) async {
    getLocation1();
    print("3EEEEEEEEEEEEEEEE");
    print('${position?.latitude},${position?.longitude}');
    //'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    // String googleUrl = 'https://www.google.com/maps/dir/${26.20654859365006},${50.533008485715904}/@$lat,$lng';
    String googleUrl =
        'https://www.google.com/maps/dir/${position?.latitude ?? 26.20654859365006},${position?.longitude ?? 50.533008485715904}/${title!.replaceAll(',', '+')}/@$lat,$lng,1d$lng!2d$lat!1d$lng!2d$lat';
    print("URL ===   $googleUrl");
    // await launchUrl(Uri.parse(googleUrl));
    // return googleUrl;
    // MapsLauncher.launchCoordinates(
    //     double.parse(lat), double.parse(long), title);
    // final availableMaps = await MapLauncher.installedMaps;
    // for (var map in availableMaps) {
    //   await map.showMarker(
    //       coords: Coords(double.parse(lat), double.parse(long)),
    //       title: title,
    //       description: title,
    //       zoom: 15);
    // }
  }

  double latitude = 26.2235;
  double longitude = 50.5876;
  double? currentLatitude;
  double? currentLongitude;
  LocationPermission? permission;
  Future<Position> determineLoc() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();

    print("STATUS----------> $permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      update();
    }

    if (permission == LocationPermission.deniedForever) {
      snackBar("Location services are permanently disabled. Please click here to Enable", onTap: () {
        openAppSettings();
      }, duration: 20000);
      update();
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getCurrentLocation() async {
    try {
      Position position = await determineLoc();
      latitude = position.latitude;
      longitude = position.longitude;

      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print('CURRENT LATITUDE $latitude CURRENT LONGITUDE $longitude');

      update();
      return position;
    } on LocationServiceDisabledException catch (e) {
      print("######################################### $e");
      return position!;
    }
  }
}
