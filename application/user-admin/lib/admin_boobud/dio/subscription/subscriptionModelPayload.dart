import '../DeviceInfoModel/DeviceInfo.dart';

class SubscriptionModelPayload {
  String? planName;
  String? plan;
  int? term;
  String? amount;
  String? remarks;
  String? isActive;
  int? isDefault;
  String? startTime;
  DeviceInfo? deviceInfo;

  SubscriptionModelPayload(
      {this.planName,
      this.plan,
      this.term,
      this.amount,
      this.remarks,
      this.isActive,
      this.isDefault,
      this.startTime,
      this.deviceInfo});

  SubscriptionModelPayload.fromJson(Map json) {
    planName = json['plan_name'];
    plan = json['plan'];
    term = json['term'];
    amount = json['amount'];
    remarks = json['remarks'];
    isActive = json['isactive'];
    isDefault = json['isDefault'];
    startTime = json['starttime'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map toJson() {
    final Map data = {};
    data['plan_name'] = planName;
    data['plan'] = plan;
    data['term'] = term;
    data['amount'] = amount;
    data['remarks'] = remarks;
    data['isactive'] = isActive;
    data['isDefault'] = isDefault;
    data['starttime'] = startTime;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}

