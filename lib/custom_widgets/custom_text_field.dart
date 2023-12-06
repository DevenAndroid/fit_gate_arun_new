// ignore_for_file: prefer_const_constructors

import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/my_color.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? image;
  final GestureTapCallback? onTap;
  final Color? color;
  final Color? fillColor;
  final Color? lblColor;
  final Color? hintColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final bool? autofocus;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;
  final onOutSideClick;
  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.onTap,
    this.controller,
    this.autofocus = false,
    this.obscureText,
    this.onPressed,
    this.image,
    this.color,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.keyboardType,
    this.maxLine,
    this.prefixIcon,
    this.hintColor,
    this.suffixIcon,
    this.fillColor,
    this.readOnly,
    this.lblColor,
    this.maxLength,
    List? inputFormatters,
    this.onOutSideClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(
                    color: lblColor ?? MyColors.grey,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500),
              ),
        SizedBox(height: 1.5),
        TextFormField(
          style: TextStyle(
            color: MyColors.black,
          ),
          onTap: onTap,
          onChanged: onChanged,
          maxLines: maxLine,
          validator: validator,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          controller: controller,
          autofocus: autofocus!,
          obscureText: obscureText ?? false,
          cursorColor: MyColors.black,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            counterText: "",
            // contentPadding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
            ),
            // prefixText: "+973",
            prefixIcon: prefixIcon == null
                ? null
                : GestureDetector(
                    onTap: onPressed,
                    child: ImageButton(
                      width: 10,
                      height: 10,
                      padding: EdgeInsets.all(16),
                      image: prefixIcon,
                      color: MyColors.grey,
                    )),
            suffixIcon: suffixIcon == null
                ? null
                : GestureDetector(
                    onTap: onPressed,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: ImageButton(
                        padding: EdgeInsets.all(5),
                        width: 17,
                        image: suffixIcon,
                        color: MyColors.grey,
                      ),
                    )),
            hintText: "$hint",
            hintStyle: TextStyle(
              color: hintColor ?? MyColors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

var border = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(7)),
  borderSide: BorderSide(color: MyColors.grey.withOpacity(.40), width: 1.5),
);

class CustomUnderlineTxt extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  const CustomUnderlineTxt(
      {Key? key,
      this.title,
      this.color,
      this.size,
      this.onTap,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "$title",
        style: TextStyle(
            fontSize: size ?? 15,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? MyColors.orange,
            decoration: TextDecoration.underline),
      ),
    );
  }
}

class RegisterTextFieldWidget extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool? readOnly;
  final dynamic value = 0;
  final dynamic minLines;
  final dynamic maxLines;
  final bool? obscureText;
  final VoidCallback? onTap;
  final length;
  List<TextInputFormatter>? inputFormatters = [];
  RegisterTextFieldWidget({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.inputFormatters,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Color(0xFF384953)),
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly!,
      controller: controller,
      obscureText: hint == hint ? obscureText! : false,
      autofillHints: autofillHints,

      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minLines,
      maxLines: maxLines,
      // cursorColor: AppTheme.primaryColor,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(

          hintText: hint,
          focusColor: const Color(0xFF384953),
          hintStyle: GoogleFonts.quicksand(
            color: const Color(0xFF696969),
            textStyle: GoogleFonts.quicksand(
              color: const Color(0xFF696969),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            fontSize: 14,
            // fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(.10),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF384953).withOpacity(.24)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFF384953).withOpacity(.24)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          border: OutlineInputBorder(
              borderSide:
              BorderSide(color:const Color(0xFF384953).withOpacity(.24), width: 3.0),
              borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: suffix,
          prefixIcon: prefix),
    );
  }
}