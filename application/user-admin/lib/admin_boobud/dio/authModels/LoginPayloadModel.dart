import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';

class LoginPayloadModel {
  String? email;
  String? password;
  DeviceInfo? deviceInfo;

  LoginPayloadModel({this.email, this.password, this.deviceInfo});

  LoginPayloadModel.fromJson(Map json) {
    email = json['email'];
    password = json['password'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map toJson() {
    final Map data = {};
    data['email'] = email;
    data['password'] = password;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
