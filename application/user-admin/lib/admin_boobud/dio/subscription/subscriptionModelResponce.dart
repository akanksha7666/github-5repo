class SubscriptionModelResponse {
  String? status;
  String? message;
  DataSub? data;

  SubscriptionModelResponse({this.status, this.message, this.data});

  SubscriptionModelResponse.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataSub.fromJson(json['data']) : null;
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

class DataSub {
  String? subscriptionId;
  String? planName;
  String? plan;
  int? term;
  double? amount;
  String? starttime;
  String? endtime;
  String? remarks;
  bool? isactive;

  DataSub(
      {this.subscriptionId,
      this.planName,
      this.plan,
      this.term,
      this.amount,
      this.starttime,
      this.endtime,
      this.remarks,
      this.isactive});

  DataSub.fromJson(Map json) {
    subscriptionId = json['subscription_id'];
    planName = json['plan_name'];
    plan = json['plan'];
    term = json['term'];
    amount = json['amount'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    remarks = json['remarks'];
    isactive = json['isactive'];
  }

  Map toJson() {
    final Map data = {};
    data['subscription_id'] = subscriptionId;
    data['plan_name'] = planName;
    data['plan'] = plan;
    data['term'] = term;
    data['amount'] = amount;
    data['starttime'] = starttime;
    data['endtime'] = endtime;
    data['remarks'] = remarks;
    data['isactive'] = isactive;
    return data;
  }
}
