/*
import 'package:fit_gate/controller/gym_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

*/
/*class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    _cameraPosition =
        CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 17);
  }

  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymController>(
      builder: (con) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Maps Sample App'),
              backgroundColor: Colors.green[700],
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                    onMapCreated: (GoogleMapController mapController) {
                      _mapController = mapController;
                      // con.setMapController(mapController);
                    },
                    initialCameraPosition: _cameraPosition),
                Positioned(
                  top: 100,
                  left: 10,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.dialog(
                          LocationSearchDialog(mapController: _mapController));
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            '${con.pickPlaceMark.name ?? ''} ${con.pickPlaceMark.locality ?? ''} '
                            '${con.pickPlaceMark.postalCode ?? ''} ${con.pickPlaceMark.country ?? ''}',
                            style: TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.search,
                            size: 25,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ]),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}*/ /*


class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.all(15),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
            height: 50,
            // width: 350,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'Search Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).disabledColor,
                      ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: 20,
                    ),
              ),
              suggestionsCallback: (pattern) async {
                print("0000000000000000000 -----------------");
                return "";
              },
              itemBuilder: (context, Prediction suggestion) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Icon(Icons.location_on),
                    Expanded(
                      child: Text(suggestion.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color,
                                    fontSize: 20,
                                  )),
                    ),
                  ]),
                );
              },
              onSuggestionSelected: (Prediction suggestion) {
                print(
                    "My location is ---------------     ${suggestion.description!}");
                //Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                // Get.back();
              },
            )),
      ),
    );
  }
}
*/
