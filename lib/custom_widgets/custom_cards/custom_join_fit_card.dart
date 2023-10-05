// ignore_for_file: prefer_const_constructors

import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';

class CustomJoinFitCard extends StatelessWidget {
  final String? title;
  final String? img;
  final Color? iconClr;
  final Color? color;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? fontSize;
  final bool? isJoinFitGate;
  final bool isOffer;
  // final double? iconSize;
  final IconData? icon;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;

  const CustomJoinFitCard(
      {Key? key,
      this.title,
      this.img,
      this.iconClr,
      this.index,
      this.selectedIndex,
      this.onClick,
      this.height,
      this.width,
      this.borderRadius,
      this.iconSize,
      this.boxShadow,
      this.icon,
      this.fontSize,
      this.color,
      this.isJoinFitGate,
      this.isOffer = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: height ?? MediaQuery.of(context).size.height * 0.15,
          width: width,
          decoration: BoxDecoration(
            color: color ?? MyColors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            border: Border.all(color: index == selectedIndex ? MyColors.orange : MyColors.white),
            boxShadow: [
              boxShadow ??
                  BoxShadow(
                    color: index == selectedIndex ? MyColors.orange.withOpacity(0.16) : MyColors.grey.withOpacity(0.20),
                    spreadRadius: 7,
                    blurRadius: 22,
                  ),
            ],
          ),
          child: isJoinFitGate == true
              ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ImageButton(
                        image: img,
                        color: index == selectedIndex ? MyColors.orange : MyColors.black,
                        height: iconSize ?? 50,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "$title",
                        style: TextStyle(
                          color: index == selectedIndex ? MyColors.orange : MyColors.black,
                          fontSize: fontSize ?? 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    img == null
                        ? SizedBox()
                        : ImageButton(
                            // padding: EdgeInsets.zero,
                            image: img,
                            color: index == selectedIndex ? MyColors.orange : MyColors.black,
                            height: iconSize ?? 50,
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title",
                          style: TextStyle(
                            color: index == selectedIndex ? MyColors.orange : MyColors.black,
                            fontSize: fontSize ?? 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isOffer
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: ImageButton(
                                      image: MyImages.offer,
                                      height: 13,
                                      width: 13,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Save 6BHD!",
                                      style: TextStyle(
                                        color: MyColors.orange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomGymCard extends StatelessWidget {
  final String? title;
  final String img;
  final Color? titleClr;
  final double? height;
  final double? width;
  final double? iconSize;
  final IconData? icon;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;

  const CustomGymCard(
      {Key? key,
      this.title,
      required this.img,
      this.titleClr,
      this.index,
      this.selectedIndex,
      this.onClick,
      this.height,
      this.width,
      this.borderRadius,
      this.iconSize,
      this.boxShadow,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        // height: height ?? MediaQuery.of(context).size.height * 0.15,
        // width: width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: Border.all(color: MyColors.border.withOpacity(0.5), width: 1.5),
          // boxShadow: [
          //   boxShadow ??
          //       BoxShadow(
          //         color: index == selectedIndex
          //             ? MyColors.orange.withOpacity(0.20)
          //             : MyColors.grey.withOpacity(0.15),
          //         spreadRadius: 4,
          //         blurRadius: 7,
          //       ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(width: 5),
              // Expanded(
              //   flex: 1,
              //   child: ImageButton(
              //     padding: EdgeInsets.zero,
              //     image: img,
              //     height: iconSize ?? 40,
              //     width: iconSize ?? 40,
              //   ),
              // ),
              Expanded(
                flex: 0,
                child: Image.asset(
                  img,
                  height: 22,
                  width: 22,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 0,
                child: Text(
                  "$title",
                  // textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: titleClr,
                    fontSize: 13.5,
                  ),
                ),
              ),
              // SizedBox(width: 10)
            ],
          ),
        ),
      ),
    );
  }
}
