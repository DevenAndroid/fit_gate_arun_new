import 'package:flutter/material.dart';

import '../../../utils/my_color.dart';

class CustomRadio extends StatelessWidget {
  final String? title;
  final String? value;
  final String? groupValue;
  final ValueChanged? onChanged;

  const CustomRadio(
      {Key? key, this.title, this.onChanged, this.value, this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? character = "";
    return Row(
      children: [
        Radio(
            activeColor: MyColors.orange,
            value: value,
            groupValue: groupValue,
            visualDensity: VisualDensity.comfortable,
            onChanged: onChanged),
        Text(
          "$title",
          style: TextStyle(
              fontSize: 14, color: MyColors.grey, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final Function(bool?)? onchanged;
  final String? title;
  final MaterialStateProperty<Color?>? color;
  final bool? value;
  const CustomCheckbox(
      {Key? key, this.onchanged, this.value, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.comfortable,
          fillColor: color ?? MaterialStateProperty.all(MyColors.orange),
          onChanged: onchanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          value: value,
          // activeColor: MyColors.green,
          // checkColor: MyColors.white,
          side: BorderSide(color: MyColors.orange, width: 1.2),
        ),
        SizedBox(width: 5),
        Text(
          "$title",
          style: TextStyle(
              fontSize: 16, color: MyColors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
