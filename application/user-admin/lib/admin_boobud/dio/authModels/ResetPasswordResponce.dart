class ResetPasswordResponce {
  String? status;
  String? message;

  ResetPasswordResponce({this.status, this.message});

  ResetPasswordResponce.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
  }

  Map toJson() {
    final Map data = {};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
