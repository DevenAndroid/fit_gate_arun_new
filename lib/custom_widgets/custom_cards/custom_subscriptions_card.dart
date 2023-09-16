import 'package:fit_gate/models/subscription_list_model.dart';
import 'package:fit_gate/screens/subscription_page.dart';
import 'package:flutter/material.dart';

import '../../utils/my_color.dart';
import '../../utils/my_images.dart';
import '../custom_btns/icon_button.dart';

class GymPackage {
  final Color? color;
  final Color? borderColor;
  final String? image;
  final String? title;
  final String? price;

  final String? noOfGym;
  GymPackage(this.borderColor, this.title, this.price, this.noOfGym, this.color,
      this.image);
}

class CustomSubscriptionCard extends StatelessWidget {
  final GymPackage gymPackage;
  final double? iconSize;
  final int? index;
  final int? selectedIndex;
  final SubscriptionListModel? model;
  final VoidCallback? onClick;
  CustomSubscriptionCard({
    Key? key,
    this.iconSize,
    this.index,
    this.selectedIndex,
    this.onClick,
    required this.gymPackage,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        // height: height ?? MediaQuery.of(context).size.height * 0.12,
        // width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: gymPackage.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: index == selectedIndex
                ? gymPackage.borderColor!
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageButton(
                      padding: EdgeInsets.zero,
                      image: gymPackage.image,
                      // width: 29,
                      // height: 29,
                      // height: 100,
                      // width: MediaQuery.of(context).size.width * 0.9,
                      // height: MediaQuery.of(context).size.height * 4,
                      // color: MyColors.orange,
                      // size: iconSize ?? 50,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model?.planName![0].toUpperCase()}${model?.planName!.substring(1)}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "BD${model?.amount} / ${model?.intervalType}",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontSize: 14.5,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Total of ${model?.totalGym} gyms",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontSize: 14.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
