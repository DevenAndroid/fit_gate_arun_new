class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic companyId;
  dynamic customerId;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic facilityName;
  dynamic email;
  dynamic countryCode;
  dynamic phoneNumber;
  dynamic firebaseId;
  dynamic fcmToken;
  dynamic avatar;
  dynamic gender;
  dynamic dob;
  dynamic type;
  dynamic area;
  dynamic logo;
  dynamic pictures;
  dynamic branch;
  dynamic amenities;
  dynamic classType;
  dynamic workingHour;
  dynamic about;
  dynamic addressAddress;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic status;
  dynamic countryName;
  dynamic reason;
  dynamic review;
  dynamic rating;
  dynamic announcement;
  dynamic uppid;
  dynamic subscriptionType;
  dynamic subUserType;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic categoryId;
  dynamic planEmail;
  dynamic cprNo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deleteStatus;

  Data(
      {this.id,
        this.companyId,
        this.customerId,
        this.name,
        this.middleName,
        this.lastName,
        this.facilityName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.firebaseId,
        this.fcmToken,
        this.avatar,
        this.gender,
        this.dob,
        this.type,
        this.area,
        this.logo,
        this.pictures,
        this.branch,
        this.amenities,
        this.classType,
        this.workingHour,
        this.about,
        this.addressAddress,
        this.addressLatitude,
        this.addressLongitude,
        this.status,
        this.countryName,
        this.reason,
        this.review,
        this.rating,
        this.announcement,
        this.uppid,
        this.subscriptionType,
        this.subUserType,
        this.emailVerifiedAt,
        this.password,
        this.categoryId,
        this.planEmail,
        this.cprNo,
        this.createdAt,
        this.updatedAt,
        this.deleteStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    customerId = json['customer_id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    facilityName = json['facility_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    firebaseId = json['firebase_id'];
    fcmToken = json['fcm_token'];
    avatar = json['avatar'];
    gender = json['gender'];
    dob = json['dob'];
    type = json['type'];
    area = json['area'];
    logo = json['logo'];
    pictures = json['pictures'];
    branch = json['branch'];
    amenities = json['amenities'];
    classType = json['class_type'];
    workingHour = json['working_hour'];
    about = json['about'];
    addressAddress = json['address_address'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
    status = json['status'];
    countryName = json['country_name'];
    reason = json['reason'];
    review = json['review'];
    rating = json['rating'];
    announcement = json['announcement'];
    uppid = json['uppid'];
    subscriptionType = json['subscription_type'];
    subUserType = json['sub_user_type'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    categoryId = json['category_id'];
    planEmail = json['plan_email'];
    cprNo = json['cpr_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deleteStatus = json['delete_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['facility_name'] = this.facilityName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['firebase_id'] = this.firebaseId;
    data['fcm_token'] = this.fcmToken;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['type'] = this.type;
    data['area'] = this.area;
    data['logo'] = this.logo;
    data['pictures'] = this.pictures;
    data['branch'] = this.branch;
    data['amenities'] = this.amenities;
    data['class_type'] = this.classType;
    data['working_hour'] = this.workingHour;
    data['about'] = this.about;
    data['address_address'] = this.addressAddress;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    data['status'] = this.status;
    data['country_name'] = this.countryName;
    data['reason'] = this.reason;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['announcement'] = this.announcement;
    data['uppid'] = this.uppid;
    data['subscription_type'] = this.subscriptionType;
    data['sub_user_type'] = this.subUserType;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['category_id'] = this.categoryId;
    data['plan_email'] = this.planEmail;
    data['cpr_no'] = this.cprNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delete_status'] = this.deleteStatus;
    return data;
  }
}
