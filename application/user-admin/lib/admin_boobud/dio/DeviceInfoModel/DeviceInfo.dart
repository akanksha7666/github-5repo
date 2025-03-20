class DeviceInfo {
  String? appVersion;
  String? countryName;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? os;

  DeviceInfo(
      {this.appVersion,
      this.countryName,
      this.deviceId,
      this.deviceName,
      this.deviceType,
      this.os});

  DeviceInfo.fromJson(Map json) {
    appVersion = json['appVersion'];
    countryName = json['countryname'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    deviceType = json['deviceType'];
    os = json['os'];
  }

  Map toJson() {
    final Map data = {};
    data['appVersion'] = appVersion;
    data['countryname'] = countryName;
    data['deviceId'] = deviceId;
    data['deviceName'] = deviceName;
    data['deviceType'] = deviceType;
    data['os'] = os;
    return data;
  }
}
