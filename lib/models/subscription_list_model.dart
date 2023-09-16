class SubscriptionListModel {
  String? id;
  String? planName;
  String? totalGym;
  String? amount;
  String? intervalType;
  String? period;
  String? createdAt;
  String? updatedAt;
  String? subscriptionId;

  SubscriptionListModel(
      {this.id,
      this.planName,
      this.totalGym,
      this.amount,
      this.intervalType,
      this.period,
      this.createdAt,
      this.updatedAt,
      this.subscriptionId});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    totalGym = json['total_gym'];
    amount = json['amount'];
    intervalType = json['interval_type'];
    period = json['period'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subscriptionId = json['subscription_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_name'] = this.planName;
    data['total_gym'] = this.totalGym;
    data['amount'] = this.amount;
    data['interval_type'] = this.intervalType;
    data['period'] = this.period;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subscription_id'] = this.subscriptionId;
    return data;
  }
}
