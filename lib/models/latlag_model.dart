import 'package:fit_gate/models/gym_details_model.dart';

class LatLngModel {
  String? id;
  GymDetailsModel? gymDetailsModel;
  String? facilityName;
  String? addressLatitude;
  String? addressLongitude;

  LatLngModel(
      {this.id,
      this.gymDetailsModel,
      this.facilityName,
      this.addressLatitude,
      this.addressLongitude});

  LatLngModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    gymDetailsModel = json['get_gym_array'] != null
        ? new GymDetailsModel.fromJson(json['get_gym_array'])
        : null;
    facilityName = json['facility_name'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.gymDetailsModel != null) {
      data['get_gym_array'] = this.gymDetailsModel!.toJson();
    }
    data['facility_name'] = this.facilityName;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    return data;
  }
}
