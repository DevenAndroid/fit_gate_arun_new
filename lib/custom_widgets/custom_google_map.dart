// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:fit_gate/models/gym_details_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class CustomGoogleMapPage extends StatefulWidget {
  final double? height;
  final CameraPosition? position;
  final String? addressName;
  // final List<MarkerList>? markers;
  GoogleMapController? googleMapController;
  CustomGoogleMapPage({
    Key? key,
    this.height,
    this.googleMapController,
    this.position,
    this.addressName,
  }) : super(key: key);

  @override
  State<CustomGoogleMapPage> createState() => _CustomGoogleMapPageState();
}

class _CustomGoogleMapPageState extends State<CustomGoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition position =
      CameraPosition(target: LatLng(26.17706, 50.60287), zoom: 12);

  List<MarkerList> markers = [];

  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? MediaQuery.of(context).size.height * 0.4,
      child: GoogleMap(
        initialCameraPosition: widget.position ?? position,
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
        buildingsEnabled: true,
        markers: markers.map((e) => e.marker).toSet(),
        onTap: (latLag) {
          setState(() {
            if (markers.isEmpty) {
              final id = uuid.v4();
              print("UUID IDDDD ${id}");
              markers.add(MarkerList(
                Marker(
                  markerId: MarkerId(id),
                  infoWindow:
                      InfoWindow(title: widget.addressName, snippet: id),
                  position: latLag,
                ),
              ));
            }
          });
        },
        onMapCreated: (GoogleMapController controller) {
          widget.googleMapController = controller;
          // _controller.complete(controller);
        },
      ),
    );
  }
}

class MarkerList {
  final Marker marker;
  MarkerList(this.marker);
}
