// import 'dart:convert';
//
// import 'package:fit_gate/global_functions.dart';
// import 'package:fit_gate/models/user_model.dart';
// import 'package:fit_gate/utils/database_helper.dart';
// import 'package:fit_gate/utils/end_points.dart';
// import 'package:get/get.dart';
//
// import '../models/gym_details_model.dart';
//
// class PackageController extends GetxController {
//   var packageList = <GymDetailsModel>[].obs;
//   getPackageListByName({String? packageName}) async {
//     var response = await DataBaseHelper.post(
//         EndPoints.packageListByName, {"class_type": packageName});
//     var parsedData = jsonDecode(response.body);
//     if (parsedData['statusCode'] == 200) {
//       var list =
//           (parsedData as List).map((e) => GymDetailsModel.fromJson(e)).toList();
//       packageList.value = list;
//       update();
//     } else {
//       return packageList.value = [];
//     }
//   }
// }
