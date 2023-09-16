import 'package:flutter/material.dart';
import '../../utils/my_color.dart';
import '../../utils/my_images.dart';
import '../../utils/my_string.dart';

class CustomPaymentBottomSheet {
  Future<dynamic> bottomSheetFilter(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("data"),
                ],
              ),
            ),
          );
        });
  }
}
