import 'dart:math';

class UserDataModel {
  final String id;
  final String name;
  final String email;
  final String subscriptionStatus;
  final String verificationStatus;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.subscriptionStatus,
    required this.verificationStatus,
  });

  // Convert JSON to UserDataModel
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      verificationStatus: json['verificationStatus'] ?? '',
    );
  }

  // Convert UserDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'subscriptionStatus': subscriptionStatus,
      'verificationStatus': verificationStatus,
    };
  }
}

List<UserDataModel> generateDummyUsers(int count) {
  List<UserDataModel> users = [];
  List<String> subscriptionStatuses = ["Approved", "Rejected", "Pending"];
  List<String> verificationStatuses = ["Approved", "Rejected", "Pending"];

  for (int i = 1; i <= count; i++) {
    users.add(UserDataModel(
      id: i.toString(),
      name: "User $i",
      email: "user$i@example.com",
      subscriptionStatus: subscriptionStatuses[Random().nextInt(subscriptionStatuses.length)],
      verificationStatus: verificationStatuses[Random().nextInt(verificationStatuses.length)],
    ));
  }
  return users;
}
