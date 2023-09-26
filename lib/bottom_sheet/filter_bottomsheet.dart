import 'package:fit_gate/controller/image_controller.dart';
import 'package:fit_gate/controller/map_controller.dart';
import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_color.dart';

filterBottomSheet(context) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      backgroundColor: MyColors.white,
      context: context,
      builder: (_) {
        int typeIndex = 0;
        int amenitiesIndex = 0;
        int? kmIndex;
        List<String> selectedAmenities = [];
        // bool select = false;
        var img = Get.put(ImageController());
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            // height: MediaQuery.of(context).size.height * 0.20,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10, top: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 2,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Filters",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Gym Type",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Tile(
                            onTap: () {
                              typeIndex = 1;
                              setState(() {});
                            },
                            title: "Free",
                            index: typeIndex,
                            sIndex: 1,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Tile(
                            onTap: () {
                              typeIndex = 2;
                              setState(() {});
                            },
                            title: "Pro",
                            index: typeIndex,
                            sIndex: 2,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Distance",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    // Wrap(
                    //   spacing: 10.0,
                    //   runSpacing: .0,
                    //   children: List.generate(
                    //       km.length,
                    //       (index) => ChoiceChip(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(6)),
                    //             backgroundColor: km[index].selected
                    //                 ? MyColors.orange
                    //                 : MyColors.lightGrey,
                    //             // shape: OutlinedBorder(),
                    //             label: Text(
                    //               km[index].title,
                    //               style: TextStyle(
                    //                 color: km[index].selected
                    //                     ? MyColors.white
                    //                     : MyColors.grey,
                    //               ),
                    //             ),
                    //             pressElevation: 0,
                    //             selected: km[index].selected == index,
                    //             showCheckmark: false,
                    //             selectedColor: MyColors.orange,
                    //             onSelected: (val) {
                    //               kmIndex = val ? index : null;
                    //               // select = val;
                    //               // km[index].selected = val;
                    //               // km[kmIndex].selected = false;
                    //               setState(() {});
                    //             },
                    //           )).toList(),
                    // ),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: .0,
                      children: List.generate(
                        km.length,
                        (int index) {
                          return ChoiceChip(
                            backgroundColor: MyColors.lightGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            label: Text(
                              '${km[index].title}',
                              style: TextStyle(
                                color: kmIndex == index
                                    ? MyColors.white
                                    : MyColors.grey,
                              ),
                            ),
                            selectedColor: MyColors.orange,
                            selected: kmIndex == index,
                            onSelected: (bool selected) {
                              setState(() {
                                kmIndex = selected ? index : null;
                              });
                              print("km index $kmIndex");
                            },
                          );
                        },
                      ).toList(),
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Amenities",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: .0,
                      children: List.generate(
                        amenities.length,
                        (index) => FilterChip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          backgroundColor: amenities[index].selected
                              ? MyColors.orange
                              : MyColors.lightGrey,
                          // shape: OutlinedBorder(),
                          label: Text(
                            amenities[index].title,
                            style: TextStyle(
                              color: amenities[index].selected
                                  ? MyColors.white
                                  : MyColors.grey,
                            ),
                          ),
                          pressElevation: 0,
                          selected: amenities[index].selected,
                          showCheckmark: false,
                          selectedColor: MyColors.orange,
                          onSelected: (val) {
                            // select = val;
                            amenitiesIndex = index;
                            amenities[index].selected = val;
                            if (val == true) {
                              selectedAmenities.add(amenities[index].title);
                            }
                            setState(() {});
                            print(" &&&&&& ${selectedAmenities}");
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              height: MediaQuery.of(context).size.height * 0.06,
                              bgColor: MyColors.white,
                              borderColor: MyColors.white,
                              fontColor: MyColors.orange,
                              title: "Clear Filters",
                              boxShadow: BoxShadow(
                                color: MyColors.lightGrey.withOpacity(.70),
                                blurRadius: 6,
                                spreadRadius: 4,
                              ),
                              onTap: () {
                                // km[kmIndex ?? 0].selected = false;
                                for (var value in amenities) {
                                  value.selected = false;
                                }
                                // km.remove(km.last.selected);
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: GetBuilder<MapController>(builder: (data) {
                              return CustomButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                title: "Confirm",
                                onTap: () async {
                                  await data.getPackageListByName(
                                    amenities: amenitiesIndex == 0
                                        ? ""
                                        : amenities[amenitiesIndex].title,
                                    distance: kmIndex == null
                                        ? ""
                                        : km[kmIndex ?? 0].title,
                                    subUserType: typeIndex == 1
                                        ? "free"
                                        : typeIndex == 2
                                            ? "pro"
                                            : "",
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}

List<FilterModel> km = [
  FilterModel(title: "Less then 5KM"),
  FilterModel(title: "Less then 10KM"),
  FilterModel(title: "Less then 15KM"),
  FilterModel(title: "Less then 20KM"),
  FilterModel(title: "Less then 25KM"),
];
List<FilterModel> amenities = [
  FilterModel(title: "Sauna"),
  FilterModel(title: "Cafes"),
  FilterModel(title: "Swimming Pool"),
  FilterModel(title: "Lockers"),
  FilterModel(title: "Jacuzzi"),
  FilterModel(title: "Restaurants"),
  FilterModel(title: "Steam"),
  FilterModel(title: "Shower"),
  FilterModel(title: "Parking"),
  FilterModel(title: "Group Class"),
  FilterModel(title: "Crossfit"),
  FilterModel(title: "Cardio"),
  FilterModel(title: "Outdoor pool"),
  FilterModel(title: "Boxing"),
];

class Tile extends StatelessWidget {
  final String? title;
  final int? index;
  final int? sIndex;
  final VoidCallback? onTap;
  const Tile({
    super.key,
    this.title,
    this.index,
    this.sIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 00),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: sIndex == index ? MyColors.orange : MyColors.lightGrey,
        ),
        child: Center(
          child: Text(
            "${title}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: sIndex == index ? MyColors.white : MyColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterModel {
  final String title;
  bool selected;

  FilterModel({required this.title, this.selected = false});
}
// SizedBox(
//                       // height: 200,
//                       child: GridView.builder(
//                           shrinkWrap: true,
//                           itemCount: km.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             childAspectRatio: 7 / 3,
//                           ),
//                           itemBuilder: (c, index) {
//                             return Tile(
//                               onTap: () {
//                                 kmIndex = index;
//                                 setState(() {});
//                               },
//                               title: km[index].title,
//                               index: index,
//                               sIndex: kmIndex,
//                             );
//                           }),
//                     ),
