import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final ImageProvider? image;
  const CustomCircleAvatar({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      backgroundColor: Colors.blue.shade200,
      backgroundImage: image,
    );
  }
}
