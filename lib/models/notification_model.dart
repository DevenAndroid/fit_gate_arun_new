class NotificationModel {
  String? id;
  String? userId;
  String? tittle;
  String? message;
  String? status;
  String? createdAt;

  NotificationModel(
      {this.id,
      this.userId,
      this.tittle,
      this.message,
      this.status,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    tittle = json['tittle'].toString();
    message = json['message'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['tittle'] = this.tittle;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
