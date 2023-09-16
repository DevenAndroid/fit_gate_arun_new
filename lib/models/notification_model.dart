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
    id = json['id'];
    userId = json['user_id'];
    tittle = json['tittle'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
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
