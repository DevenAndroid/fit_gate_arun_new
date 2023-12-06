class PaymentModel {
  String? result;
  String? status;

  PaymentModel({this.result, this.status});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['status'] = this.status;
    return data;
  }
}
