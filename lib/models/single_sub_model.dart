class SingleSubscriptionModel {
  bool? status;
  String? message;
  Data? data;

  SingleSubscriptionModel({this.status, this.message, this.data});

  SingleSubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? gymId;
  String? title;
  String? discription;
  int? price;
  int? previousPrice;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.gymId,
        this.title,
        this.discription,
        this.price,
        this.previousPrice,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gymId = json['gym_id'];
    title = json['title'];
    discription = json['discription'];
    price = json['price'];
    previousPrice = json['previous_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gym_id'] = this.gymId;
    data['title'] = this.title;
    data['discription'] = this.discription;
    data['price'] = this.price;
    data['previous_price'] = this.previousPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
