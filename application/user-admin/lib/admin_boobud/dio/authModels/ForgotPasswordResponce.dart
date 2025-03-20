class ForgotPasswordResponce {
  String? status;
  String? message;

  ForgotPasswordResponce({this.status, this.message});

  ForgotPasswordResponce.fromJson(Map json) {
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
