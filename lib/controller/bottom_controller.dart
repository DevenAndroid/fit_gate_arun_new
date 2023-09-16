import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  int currentIndex = 0;
  getIndex(value) {
    currentIndex = value;
    update();
  }

  bool selectScreen = false;
  var screenNameVal = null;

  setSelectedScreen(value, {Widget? screenName}) {
    print(screenName);
    selectScreen = value;
    screenNameVal = screenName;
    update();
  }

  void resetIndex() {
    this.currentIndex = 0;
    selectScreen = false;
    update();
  }
}
