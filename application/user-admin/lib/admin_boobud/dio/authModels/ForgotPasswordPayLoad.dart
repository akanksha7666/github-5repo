
import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';

class ForgotPasswordPayLoad {
  String? email;
  DeviceInfo? deviceInfo;

  ForgotPasswordPayLoad({this.email, this.deviceInfo});

  ForgotPasswordPayLoad.fromJson(Map json) {
    email = json['email'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map toJson() {
    final Map data = {};
    data['email'] = email;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
