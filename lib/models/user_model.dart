class UserModel {
  String? id;
  String? name;
  String? middleName;
  String? countryName;
  String? area;
  String? dob;
  String? lastName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? firebaseId;
  String? fcmToken;
  String? emailVerifyStatus;
  String? avatar;
  String? gender;
  String? type;
  String? cpr_no;
  String? subscriptionPlan;
  String? subscriptionStatus;
  String? subscriptionFrom;
  String? subscriptionTo;
  String? status;
  String? deleteStatus;
  String? createdAt;

  UserModel(
      {this.id,
      this.name,
      this.middleName,
      this.countryName,
      this.area,
      this.dob,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.firebaseId,
      this.fcmToken,
      this.emailVerifyStatus,
      this.avatar,
      this.gender,
      this.type,
      this.subscriptionPlan,
      this.subscriptionStatus,
      this.subscriptionFrom,
      this.subscriptionTo,
      this.status,
      this.deleteStatus,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    countryName = json['country_name'];
    area = json['area'];
    dob = json['dob'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    firebaseId = json['firebase_id'];
    fcmToken = json['fcm_token'];
    countryCode = json['country_code'];
    emailVerifyStatus = json['email_verify_status'].toString();
    avatar = json['avatar'];
    gender = json['gender'];
    type = json['type'];
    subscriptionPlan = json['subscription_plan'];
    subscriptionStatus = json['subscription_status'];
    subscriptionFrom = json['subscription_from'];
    subscriptionTo = json['subscription_to'];
    status = json['status'];
    cpr_no = json['cpr_no'].toString();
    deleteStatus = json['delete_status'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['middle_name'] = this.middleName;
    data['country_name'] = this.countryName;
    data['area'] = this.area;
    data['dob'] = this.dob;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['firebase_id'] = this.firebaseId;
    data['fcm_token'] = this.fcmToken;
    data['country_code'] = this.countryCode;
    data['email_verify_status'] = this.emailVerifyStatus;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['subscription_plan'] = this.subscriptionPlan;
    data['subscription_status'] = this.subscriptionStatus;
    data['subscription_from'] = this.subscriptionFrom;
    data['subscription_to'] = this.subscriptionTo;
    data['status'] = this.status;
    data['cpr_no'] = this.cpr_no;
    data['delete_status'] = this.deleteStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class VersionModel {
  String? id;
  String? currentAndroidVersion;
  String? currentIosVersion;
  String? upgradeAndroidVersion;
  String? upgradeIosVersion;
  String? createdAt;
  String? updatedAt;

  VersionModel(
      {this.id,
      this.currentAndroidVersion,
      this.currentIosVersion,
      this.upgradeAndroidVersion,
      this.upgradeIosVersion,
      this.createdAt,
      this.updatedAt});

  VersionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentAndroidVersion = json['current_android_version'];
    currentIosVersion = json['current_ios_version'];
    upgradeAndroidVersion = json['upgrade_android_version'];
    upgradeIosVersion = json['upgrade_ios_version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_android_version'] = this.currentAndroidVersion;
    data['current_ios_version'] = this.currentIosVersion;
    data['upgrade_android_version'] = this.upgradeAndroidVersion;
    data['upgrade_ios_version'] = this.upgradeIosVersion;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
