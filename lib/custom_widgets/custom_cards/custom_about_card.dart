import 'package:flutter/material.dart';
import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';

import '../../utils/my_color.dart';

class CustomAboutCard extends StatelessWidget {
  final String? title;
  final String? label;
  final String? icon;
  final double? height;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  const CustomAboutCard({
    Key? key,
    this.title,
    this.icon,
    this.onTap,
    this.trailingIcon,
    this.label,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label == null
              ? const SizedBox()
              : Text(
                  "$label",
                  style: TextStyle(
                      color: MyColors.grey,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500),
                ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
                border: Border.all(
                    color: MyColors.grey.withOpacity(.50), width: 1.2),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              children: [
                ImageButton(
                  padding: EdgeInsets.all(2),
                  image: icon,
                  color: MyColors.grey,
                  height: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  "$title",
                  style: TextStyle(
                    color: MyColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                trailingIcon == null
                    ? const SizedBox()
                    : Icon(
                        trailingIcon ?? Icons.arrow_forward_ios_rounded,
                        color: MyColors.grey,
                        size: 16,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
