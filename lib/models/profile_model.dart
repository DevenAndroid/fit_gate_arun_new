class ProfileModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? gender;
  String? avatar;
  String? subscription_type;

  ProfileModel(
      {this.name,
      this.phoneNumber,
      this.email,
      this.gender,
      this.avatar,
      this.subscription_type});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    avatar = json['avatar'];
    subscription_type = json['subscription_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['subscription_type'] = this.subscription_type;
    return data;
  }
}
