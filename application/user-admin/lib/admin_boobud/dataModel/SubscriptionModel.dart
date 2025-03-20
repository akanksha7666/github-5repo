class SubscriptionModel {
  int id;
  String planName;
  String planDuration;
  String term;
  String amount;
  String remarks;
  DateTime startTime;
  DateTime endTime;

  SubscriptionModel({
    required this.id,
    required this.planName,
    required this.planDuration,
    required this.term,
    required this.amount,
    required this.remarks,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor for JSON parsing
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? 0,
      planName: json['plan_name'] ?? '',
      planDuration: json['planDuration'] ?? '',
      term: json['term'] ?? '',
      amount: json['amount'] ?? '',
      remarks: json['remarks'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_name': planName,
      'planDuration': planDuration,
      'term': term,
      'amount': amount,
      'remarks': remarks,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  // ✅ Fix: Pass jsonList as a parameter instead of using an instance member
  static List<SubscriptionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SubscriptionModel.fromJson(json)).toList();
  }

  static List<SubscriptionModel> getSubscriptionDummyData() {
    return List.generate(500, (index) {
      return SubscriptionModel(
        id: index + 1,
        planName: "Plan ${index + 1}",
        planDuration: "${(index + 1) * 3} Months",
        term: "User${index + 1}@example.com",
        amount: "\$${(index + 1) * 100}",
        remarks: "Remark ${(index + 1)}",
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(days: (index + 1) * 30)),
      );
    });
  }

}
