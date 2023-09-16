class ActiveSubscriptionModel {
  int? id;
  String? userId;
  String? subscriptionPackageId;
  String? subscriptionId;
  String? customerId;
  String? cardId;
  String? period;
  String? amount;
  String? status;
  String? fromDate;
  String? toDate;
  String? createdAt;
  String? updatedAt;
  String? deleteAt;
  String? planName;

  ActiveSubscriptionModel(
      {this.id,
      this.userId,
      this.subscriptionPackageId,
      this.subscriptionId,
      this.customerId,
      this.cardId,
      this.period,
      this.amount,
      this.status,
      this.fromDate,
      this.toDate,
      this.createdAt,
      this.updatedAt,
      this.deleteAt,
      this.planName});

  ActiveSubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subscriptionPackageId = json['subscription_package_id'];
    subscriptionId = json['subscription_id'];
    customerId = json['customer_id'];
    cardId = json['card_id'];
    period = json['period'];
    amount = json['amount'];
    status = json['status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deleteAt = json['delete_at'];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subscription_package_id'] = this.subscriptionPackageId;
    data['subscription_id'] = this.subscriptionId;
    data['customer_id'] = this.customerId;
    data['card_id'] = this.cardId;
    data['period'] = this.period;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delete_at'] = this.deleteAt;
    data['plan_name'] = this.planName;
    return data;
  }
}
