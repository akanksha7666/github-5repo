class LoginModelResponse {
  String? status;
  String? message;
  Data? data;

  LoginModelResponse({this.status, this.message, this.data});

  LoginModelResponse.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map toJson() {
    final Map data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  List<dynamic>? roles;
  String? country;
  bool? isActive;
  bool? mfaEnabled;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data(
      {this.userId,
      this.name,
      this.roles,
      this.country,
      this.isActive,
      this.mfaEnabled,
      this.createdAt,
      this.updatedAt,
      this.token});

  Data.fromJson(Map json) {
    userId = json['user_id'];
    name = json['name'];
    roles = json['roles'];
    country = json['country'];
    isActive = json['is_active'];
    mfaEnabled = json['mfa_enabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map toJson() {
    final Map data = {};
    data['user_id'] = userId;
    data['name'] = name;
    data['roles'] = roles;
    data['country'] = country;
    data['is_active'] = isActive;
    data['mfa_enabled'] = mfaEnabled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
