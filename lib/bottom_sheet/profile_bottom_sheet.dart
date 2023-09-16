// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fit_gate/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/my_color.dart';

class CustomCameraSheet {
  var image;
  var imagepicker = ImagePicker();

  // final csv = Get.put(CsvController());
  cameraBottomSheet(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
        backgroundColor: MyColors.white,
        context: context,
        builder: (_) {
          var img = Get.put(ImageController());
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile photo",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          img.isCamera = true;
                          Navigator.pop(context);
                          await img.getProfileImage(context);
                        },
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: MyColors.grey.withOpacity(.30),
                                        width: 1.2)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.camera,
                                    color: MyColors.orange,
                                  ),
                                )),
                            SizedBox(height: 7),
                            Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 22),
                      GestureDetector(
                        onTap: () async {
                          img.isCamera = false;
                          Navigator.pop(context);
                          await img.getProfileImage(context);
                        },
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: MyColors.grey.withOpacity(.30),
                                        width: 1.5)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.photo,
                                    color: MyColors.orange,
                                  ),
                                )),
                            SizedBox(height: 7),
                            const Text(
                              "Gallery",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: GestureDetector(
                      onTap: () async {
                        // img.isCamera = false;
                        // await csv.pickFile();
                        // await img.uploadFileData("file");

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 15),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }
}
