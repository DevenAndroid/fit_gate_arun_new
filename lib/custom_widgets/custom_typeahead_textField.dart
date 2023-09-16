// import 'package:fit_gate/models/gym_details_model.dart';
// import 'package:fit_gate/models/latlag_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'package:fit_gate/controller/map_controller.dart';
// import 'package:fit_gate/screens/gym_map_details_page.dart';
// import 'package:fit_gate/utils/my_images.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import '../custom_widgets/custom_btns/icon_button.dart';
// import '../custom_widgets/custom_google_map.dart';
// import '../models/google_map_model.dart';
// import '../utils/my_color.dart';
//
// class CustomTypeAhead extends StatefulWidget {
//   final GoogleMapController? googleMapController;
//   TextEditingController? search;
//   CustomTypeAhead({Key? key, this.googleMapController, this.search})
//       : super(key: key);
//
//   @override
//   State<CustomTypeAhead> createState() => _CustomTypeAheadState();
// }
//
// class _CustomTypeAheadState extends State<CustomTypeAhead> {
//   final mapController = Get.put(MapController());
//   List<GetLocation> searchList = [];
//   GetPlaceById? getPlaceById;
//   CameraPosition? currentPosition;
//   List<MarkerList> markers = [];
//   TextEditingController search = TextEditingController();
//
//   Future goToPlace(
//       {required double latitude,
//       required double longitude,
//       id,
//       name,
//       desc}) async {
//     await widget.googleMapController?.animateCamera(
//         CameraUpdate.newCameraPosition(
//             CameraPosition(target: LatLng(latitude, longitude), zoom: 15.0)));
//     setState(() {
//       markers.add(MarkerList(
//         Marker(
//           markerId: MarkerId(id),
//           infoWindow: InfoWindow(title: name, snippet: desc),
//           position: LatLng(latitude, longitude),
//         ),
//       ));
//     });
//     Get.to(() => GymMapDetailsPage(
//           markers: markers,
//           search: search.text,
//           lat: latitude.toString(),
//           lang: longitude.toString(),
//           position:
//               CameraPosition(target: LatLng(latitude, longitude), zoom: 15.0),
//         ));
//     print("qqqqqqq $longitude");
//     print("aaaaaaa $latitude");
//     // 26.20101942887577, 50.534209919020284
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MapController>(builder: (cont) {
//       return TypeAheadFormField(
//         textFieldConfiguration: TextFieldConfiguration(
//           controller: widget.search,
//           textInputAction: TextInputAction.search,
//           decoration: InputDecoration(
//               hintText: "Search",
//               fillColor: MyColors.white,
//               filled: true,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none),
//               contentPadding: const EdgeInsets.only(left: 15, top: 15),
//               /*      suffixIcon: ImageButton(
//                 padding: EdgeInsets.all(15),
//                 width: 10,
//                 height: 10,
//                 image: MyImages.mic,
//                 color: MyColors.grey,
//               ),*/
//               prefixIcon: ImageButton(             onTap: () async {
//                   var data = await cont.getLocation(search: search.text);
//                   if (data.isNotEmpty) {
//                     setState(() {
//                       searchList = data;
//                     });
//                   }
//                 },
//                 height: 10,
//                 width: 10,
//                 image: MyImages.search,
//                 padding: EdgeInsets.all(15),
//               ))      ),
//         suggestionsCallback: (pattern) async {
//           return await cont.getLocation(search: search.text);
//         },
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             leading: Icon(Icons.shopping_cart),
//             title: Text(suggestion.toString()),
//           );
//         },
//         onSuggestionSelected: (suggestion) async {
//           search.text = "suggestion.addressAddress!";
//           // final res = await cont.getPlaceById(suggestion.placeId!);
//           // setState(() {
//           //   getPlaceById = res;
//           //   widget.search?.text = search.text;
//           // });
//           log("Latitude ${getPlaceById!.geometry!.location!.lat!.toString()}");
//           log("Longitude ${getPlaceById!.geometry!.location!.lng!.toString()}");
//           goToPlace(
//               // id: res!.placeId,
//               // name: res.name,
//               // desc: res.formattedAddress,
//               latitude: 26.126532866193056,
//               longitude: 50.58895572492011);
//           // print("RES NAMEEEEEEEEE:--------------- ${res.formattedAddress}");
//         },
//       );
//     });
//   }
// }
