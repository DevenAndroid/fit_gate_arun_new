class CheckInModel {
  String? id;
  String? userId;
  String? qrId;
  String? name;
  String? facilityName;
  String? logo;
  String? createdAt;
  String? updatedAt;

  CheckInModel(
      {this.id,
      this.userId,
      this.qrId,
      this.name,
      this.facilityName,
      this.logo,
      this.createdAt,
      this.updatedAt});

  CheckInModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    qrId = json['qr_id'];
    name = json['name'];
    facilityName = json['facility_name'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['qr_id'] = this.qrId;
    data['name'] = this.name;
    data['facility_name'] = this.facilityName;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
