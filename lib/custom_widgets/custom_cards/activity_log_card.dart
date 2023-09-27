// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_gate/models/check_in_model.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/image_controller.dart';

class CustomActivityLogCard extends StatelessWidget {
  final String? title;
  final String? desc;
  final String? img;
  final Color? iconClr;
  final int? index;
  final int? selectedIndex;
  final CheckInModel? checkInModel;
  final void Function()? onClick;

  CustomActivityLogCard(
      {Key? key,
      this.title,
      this.img,
      this.iconClr,
      this.index,
      this.selectedIndex,
      this.onClick,
      this.desc,
      this.checkInModel})
      : super(key: key);

  final imgCon = Get.put(ImageController());
  // getDate(_date) {
  //   var inputFormat = DateFormat('yyyy-MM-dd');
  //   var inputDate = inputFormat.parse(_date);
  //   var outputFormat = DateFormat('dd/MM/yyyy');
  //   return outputFormat.format(inputDate);
  // }

  @override
  Widget build(BuildContext context) {
    // String bin = checkInModel!.createdAt.toString();
    // var format = bin.substring(bin.length - 8);
    // var time = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$format"));
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(20),
        // height: MediaQuery.of(context).size.height * 0.15,
        // width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider)),
                ),
                placeholder: (c, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: MyColors.orange,
                  ),
                ),
                imageUrl: "${EndPoints.imgBaseUrl}${checkInModel?.logo}",
                errorWidget: (c, u, r) => Container(),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${checkInModel?.name}",
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    timeFormat("${checkInModel?.createdAt}"),
                    style: TextStyle(
                      color: MyColors.grey.withOpacity(0.70),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String timeFormat(String dateTime) {
  var oldDate = DateTime.parse(dateTime);
  var newDate = DateFormat('dd MMM yyyy hh:mm a').format(oldDate);
  return newDate;
}
