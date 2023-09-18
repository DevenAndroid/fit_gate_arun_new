// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../utils/my_color.dart';
import 'icon_button.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? height;
  final Color? bgColor;
  final Color? borderColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final BoxShadow? boxShadow;
  final double? fontSize;
  final double? width;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  const CustomButton(
      {Key? key,
      this.title,
      this.height,
      this.width,
      this.onTap,
      this.borderRadius,
      this.fontWeight,
      this.fontSize,
      this.bgColor,
      this.fontColor,
      this.borderColor,
      this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.052,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: bgColor ?? MyColors.orange,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            boxShadow: [
              boxShadow ?? BoxShadow(),
            ],
            border:
                Border.all(color: borderColor ?? MyColors.orange, width: 1.2)),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: fontSize ?? 17,
              fontWeight: fontWeight ?? FontWeight.bold,
              color: fontColor ?? MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final String? title;
  final VoidCallback? onclick;
  final String? image;
  final double? height;
  final double? width;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final MaterialStateProperty<Color?>? backgroundColor;

  const CustomButtonWithIcon(
      {Key? key,
      this.title,
      this.onclick,
      this.image,
      this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.052,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.orange,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? SizedBox()
                : ImageButton(
                    padding: EdgeInsets.zero,
                    image: image,
                    height: 20,
                  ),
            SizedBox(width: 17),
            Text(
              "$title",
              style: TextStyle(
                fontSize: fontSize ?? 11.3,
                color: MyColors.white,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class DisableButton extends StatelessWidget {
//   const DisableButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 2,
//       child: CustomButton(
//         title: "Validate",
//         fontSize: 15,
//         fontWeight: FontWeight.w500,
//         height: Responsive.isMobile(context)
//             ? MediaQuery.of(context).size.height * 0.055
//             : MediaQuery.of(context).size.height * 0.04,
//         borderRadius: BorderRadius.circular(5),
//         fontColor: MyColors.white.withOpacity(0.30),
//         bgColor: MyColors.yellow.withOpacity(0.25),
//         borderColor: Colors.transparent,
//       ),
//     );
//   }
// }
