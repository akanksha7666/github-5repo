
import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginPayloadModel.dart';

class OTPModelPayLoad {
  String? email;
  String? otp;
  String? purpose;
  DeviceInfo? deviceInfo;

  OTPModelPayLoad({this.email, this.otp, this.purpose, this.deviceInfo});

  OTPModelPayLoad.fromJson(Map json) {
    email = json['email'];
    otp = json['otp'];
    purpose = json['purpose'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map toJson() {
    final Map data = {};
    data['email'] = email;
    data['otp'] = otp;
    data['purpose'] = purpose;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
