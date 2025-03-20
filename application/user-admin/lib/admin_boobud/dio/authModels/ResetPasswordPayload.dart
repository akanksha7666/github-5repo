
import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';

class ResetPasswordPayload {
  String? email;
  String? otp;
  String? password;
  DeviceInfo? deviceInfo;

  ResetPasswordPayload({this.email, this.otp, this.password, this.deviceInfo});

  ResetPasswordPayload.fromJson(Map json) {
    email = json['email'];
    otp = json['otp'];
    password = json['password'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map toJson() {
    final Map data = {};
    data['email'] = email;
    data['otp'] = otp;
    data['password'] = password;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}

