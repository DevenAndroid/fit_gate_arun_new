import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../global_functions.dart';
import '../models/profile_details_model.dart';
import '../repo/profile_details_repo.dart';

class ProfileDetailscontroller extends GetxController {
  RxBool isDataLoading = false.obs;

  String gymId =  Global.userModel!.id.toString();
  Rx<ProfileModel> model = ProfileModel().obs;

  final TextEditingController emailController=TextEditingController();
  final TextEditingController cprController=TextEditingController();

  Future getProfileDetails(id) async {
    isDataLoading.value = false;
    await profileDetailsRepo(id: id).then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (isDataLoading.value &&
          model.value.data != null) {
        emailController.text =
            model.value.data!.planEmail ?? "Enter Email ID";
        cprController.text =
            model.value.data!.cprNo ?? "Enter CPR Number";

      }
    });
  }
}
