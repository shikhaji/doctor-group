class LoginModel {
  int? status;
  String? message;
  String? id;
  String? token;
  int? type;

  LoginModel({this.status, this.message, this.id, this.token, this.type});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}