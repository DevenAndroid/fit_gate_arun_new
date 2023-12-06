class SubscriptionModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? cprNo;
  dynamic? subscriptionBannerImg;

  SubscriptionModel(
      {this.status,
        this.message,
        this.data,
        this.cprNo,
        this.subscriptionBannerImg});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    cprNo = json['cpr_no'];
    subscriptionBannerImg = json['subscription_banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['cpr_no'] = this.cprNo;
    data['subscription_banner_img'] = this.subscriptionBannerImg;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic gymId;
  dynamic title;
  dynamic discription;
  dynamic price;
  dynamic previousPrice;
  dynamic vat;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.gymId,
        this.title,
        this.discription,
        this.price,
        this.previousPrice,
        this.vat,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gymId = json['gym_id'];
    title = json['title'];
    discription = json['discription'];
    price = json['price'];
    previousPrice = json['previous_price'];
    vat = json['vat'];
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
    data['vat'] = this.vat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
