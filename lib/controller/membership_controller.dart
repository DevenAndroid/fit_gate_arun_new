import 'dart:developer';

import 'package:get/get.dart';
import '../global_functions.dart';
import '../models/single_sub_model.dart';
import '../models/subscription_model.dart';
import '../repo/subscription_list_repo.dart';

class MembershipController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxString singleSubId = "".obs;
  String gymId =  Global.userModel!.id.toString();
  Rx<SubscriptionModel> model = SubscriptionModel().obs;
  Rx<SingleSubscriptionModel> model1 = SingleSubscriptionModel().obs;


  Future getData(id) async {

    isDataLoading.value = false;
    await subscriptionDataRepo(id:id ).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

}
