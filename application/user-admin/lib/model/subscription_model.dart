import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:medicare/helpers/services/json_decoder.dart';

class SubscriptionModel {
  int id;
  final String planName;
  final String planDuration;
  final String term;
  final double amount;
  final String remarks;
  final bool isActive;
  final DateTime startTime;
  final DateTime endTime;

  SubscriptionModel({
    required this.id,
    required this.planName,
    required this.planDuration,
    required this.term,
    required this.amount,
    required this.remarks,
    required this.isActive,
    required this.startTime,
    required this.endTime,
  });

  static SubscriptionModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder jsonSubscription = JSONDecoder(json);

    return SubscriptionModel(
      id: json['id'],
      planName: jsonSubscription.getString('plan_name'),
      planDuration: jsonSubscription.getString('planDuration'),
      term: jsonSubscription.getString('term'),
      amount: jsonSubscription.getDouble('amount'),  // Ensure correct type
      remarks: jsonSubscription.getString('remarks'),
      isActive: jsonSubscription.getBool('isActive') ?? false,  // Fix missing isActive
      startTime: jsonSubscription.getDateTime('startTime'),
      endTime: jsonSubscription.getDateTime('endTime'),
    );
  }

  static List<SubscriptionModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => SubscriptionModel.fromJSON(e)).toList();
  }

  static List<SubscriptionModel>? _dummyList;

  static Future<List<SubscriptionModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/subscription_data.json');
  }
}
