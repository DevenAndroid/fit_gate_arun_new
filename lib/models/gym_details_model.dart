class GymDetailsModel {
  String? id;
  String? name;
  String? facilityName;
  String? email;
  String? phoneNumber;
  String? review;
  String? rating;
  String? distance;
  String? announcement;
  String? logo;
  List<String>? pictures;
  List<String>? amenities;
  String? classType;
  List<WorkingHour>? workingHour;
  String? about;
  String? addressAddress;
  String? addressLatitude;
  String? addressLongitude;
  String? status;
  String? sub_user_type;
  String? deleteStatus;
  String? createdAt;

  GymDetailsModel(
      {this.id,
      this.name,
      this.facilityName,
      this.email,
      this.distance,
      this.phoneNumber,
      this.review,
      this.rating,
      this.announcement,
      this.logo,
      this.pictures,
      this.amenities,
      this.classType,
      this.workingHour,
      this.about,
      this.addressAddress,
      this.addressLatitude,
      this.addressLongitude,
      this.status,
      this.sub_user_type,
      this.deleteStatus,
      this.createdAt});

  GymDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    facilityName = json['facility_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    logo = json['logo'];
    review = json['review'].toString() ?? "";
    rating = json['rating']==null?"":json['rating'].toString();
    announcement = json['announcement'] ?? "";
    distance = json['distance']==null? "":json['distance'].toString();
    pictures = json['pictures'].cast<String>();
    amenities = json['amenities'].cast<String>();
    classType = json['class_type'];
    if (json['working_hour'] != null) {
      workingHour = <WorkingHour>[];
      json['working_hour'].forEach((v) {
        if (v != null) {
          workingHour!.add(new WorkingHour.fromJson(v));
        }
      });
    }
    about = json['about'];
    distance = json['distance']==null?"":json['distance'].toString();
    addressAddress = json['address_address'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
    status = json['status'];
    sub_user_type = json['sub_user_type'];
    deleteStatus = json['delete_status'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['facility_name'] = this.facilityName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['logo'] = this.logo;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['announcement'] = this.announcement;
    data['pictures'] = this.pictures;
    data['amenities'] = this.amenities;
    data['class_type'] = this.classType;
    if (this.workingHour != null) {
      data['working_hour'] = this.workingHour!.map((v) => v.toJson()).toList();
    }
    data['about'] = this.about;
    data['address_address'] = this.addressAddress;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    data['status'] = this.status;
    data['sub_user_type'] = this.sub_user_type;
    data['delete_status'] = this.deleteStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class WorkingHour {
  String? day;
  String? start;
  String? end;

  WorkingHour({this.day, this.start, this.end});

  WorkingHour.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
