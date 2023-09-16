import 'dart:convert';

import 'package:fit_gate/models/banner_model.dart';
import 'package:fit_gate/utils/database_helper.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:get/get.dart';

import '../models/get_company_model.dart';

class BannerController extends GetxController {
  var getCompanyList = <GetCompanyModel>[].obs;
  var getBannerList = <BannerModel>[].obs;

  getCompany() async {
    var response = await DataBaseHelper.get(EndPoints.getCompany);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      var list = (parsedData['data'] as List)
          .map((e) => GetCompanyModel.fromJson(e))
          .toList();
      update();
      return getCompanyList.value = list;
    } else {
      return getCompanyList.value = [];
    }
  }

  getBanner() async {
    var response = await DataBaseHelper.get(EndPoints.getBanner);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      var list = (parsedData['data'] as List)
          .map((e) => BannerModel.fromJson(e))
          .toList();
      update();
      return getBannerList.value = list;
    } else {
      return getBannerList.value = [];
    }
  }
}
