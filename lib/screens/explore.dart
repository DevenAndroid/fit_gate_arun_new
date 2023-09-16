import 'package:fit_gate/bottom_sheet/filter_bottomsheet.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: AppBar(
            elevation: 4,
            shadowColor: MyColors.border.withOpacity(.30),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Explore",
              style: TextStyle(color: MyColors.black),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ImageButton(
                onTap: () {
                  filterBottomSheet(context);
                },
                image: MyImages.filter,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageButton(
                  image: MyImages.map,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (c, i) {
                    return GestureDetector(
                      onTap: () {
                        index = i;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: index == i
                                  ? MyColors.orange
                                  : MyColors.border.withOpacity(.40),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.grey.withOpacity(0.10),
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    // flex: 0,
                                    child: Image.asset(
                                  MyImages.bodyMaster,
                                  fit: BoxFit.cover,
                                )),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Body Master",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: MyColors.orange,
                                              size: 17,
                                            ),
                                            Text(
                                              "4.5",
                                              style: TextStyle(
                                                color: MyColors.orange,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              "250 Review",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: MyColors.grey,
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            ImageButton(
                                              padding: EdgeInsets.all(0),
                                              image: MyImages.car,
                                              color: MyColors.grey,
                                              width: 13,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "22 Km",
                                              style: TextStyle(
                                                color: MyColors.grey,
                                                fontSize: 13.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text("Pro"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
