// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/gym_details_model.dart';
import '../../utils/my_color.dart';

class CustomExploreCard extends StatefulWidget {
  final GymDetailsModel? gymDetailsModel;
  final String? title;
  final String? title1;
  final String? title2;
  final String? rate;
  final String? text;
  final String? img;
  final String? clockImg;
  final Color? cardClr;
  final Color? borderClr;
  final double? height;
  final double? iconSize;
  final int? index;
  final int? selectedIndex;
  final GoogleMapController? googleMapController;
  final VoidCallback? onClick;
  final double? lat;
  final double? log;
  Function(int)? clickCard;
  CustomExploreCard(
      {Key? key,
      this.title,
      this.img,
      this.height,
      this.iconSize,
      this.index,
      this.selectedIndex,
      this.onClick,
      this.clickCard,
      this.title1,
      this.title2,
      this.cardClr,
      this.borderClr,
      this.rate,
      this.text,
      this.clockImg,
      this.gymDetailsModel,
      this.googleMapController,
      this.lat,
      this.log})
      : super(key: key);

  @override
  State<CustomExploreCard> createState() => _CustomExploreCardState();
}

class _CustomExploreCardState extends State<CustomExploreCard> {
  final mapController = Get.put(MapController());
  getData() {
    calculateDistance();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          height: widget.height ?? MediaQuery.of(context).size.height * 0.18,
          // width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: widget.cardClr,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.index == widget.selectedIndex
                  ? widget.borderClr!
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.20),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                widget.img == null
                    ? SizedBox()
                    : Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              height: MediaQuery.of(context).size.height * 0.18,
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
                            imageUrl: "${widget.img ?? MyImages.sapphire}",
                            errorWidget: (c, u, r) => Container(),
                          ),
                        ),
                      ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.gymDetailsModel!.facilityName.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        if (widget.gymDetailsModel!.announcement.toString() !=
                            "")
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "${widget.gymDetailsModel!.announcement.toString()}",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.red,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(),
                        SizedBox(height: 5),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: MyColors.orange,
                                size: 17,
                              ),
                              if (widget.gymDetailsModel!.rating.toString() !=
                                  "")
                                Text(
                                  "${widget.gymDetailsModel!.rating.toString()}",
                                  style: TextStyle(
                                    color: MyColors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                Text(
                                  "0.0",
                                  style: TextStyle(
                                    color: MyColors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              SizedBox(width: 3),
                              if (widget.gymDetailsModel!.review.toString() !=
                                  "")
                                Text(
                                  "${widget.gymDetailsModel!.review.toString()} Review",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: MyColors.grey,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                Text(
                                  "0  Review",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: MyColors.grey,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              ImageButton(
                                padding: EdgeInsets.all(0),
                                image: widget.clockImg ?? MyImages.car,
                                color: MyColors.grey,
                                width: 13,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${widget.title2 ?? "${distance.toStringAsFixed(2)} Km"}",
                                style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 13.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                        (() {
                          if (widget.gymDetailsModel!.classType == "sapphire") {
                            return "${widget.gymDetailsModel!.classType![0].toUpperCase()}${widget.gymDetailsModel!.classType!.substring(1)}";
                          }
                          return "${widget.gymDetailsModel!.classType![0].toUpperCase()}${widget.gymDetailsModel!.classType!.substring(1)}";
                        }()),
                        overflow: TextOverflow.ellipsis,
                        style: (() {
                          if (widget.gymDetailsModel?.classType == "sapphire") {
                            return TextStyle(
                                color: MyColors.blue, fontSize: 15);
                          } else if (widget.gymDetailsModel?.classType ==
                              "emerald") {
                            return TextStyle(
                                color: MyColors.green, fontSize: 15);
                          } else {
                            return TextStyle(
                                color: MyColors.brown, fontSize: 15);
                          }
                        }())),
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
  getDistance() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {});
    distance = await Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        double.parse('${widget.gymDetailsModel!.addressLatitude}'),
        double.parse('${widget.gymDetailsModel!.addressLongitude}'));
    print("DISTANCE === ${distance / 1000}");
    // setState(() {});
    return distance;
  }

  String calculateDistance() {
    // double distance = 0.0;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((double.parse('${widget.gymDetailsModel!.addressLatitude}') -
                    mapController.latitude) *
                p) /
            2 +
        c(mapController.latitude * p) *
            c(double.parse('${widget.gymDetailsModel!.addressLatitude}') * p) *
            (1 -
                c((double.parse('${widget.gymDetailsModel!.addressLongitude}') -
                        mapController.longitude) *
                    p)) /
            2;
    // return 12742 * asin(sqrt(a));
    distance = 12742 * asin(sqrt(a));
    return (distance).toStringAsFixed(2);
  }
}
