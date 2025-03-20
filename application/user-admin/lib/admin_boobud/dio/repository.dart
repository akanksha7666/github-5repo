import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginModelResponse.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginPayloadModel.dart';
import 'package:medicare/admin_boobud/dio/dioclient.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelPayload.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelResponce.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/model/subscription_model.dart';

class Repository {
  DioClient? dioClient;

  Repository([this.dioClient]);

  /// Login Api
  Future<LoginModelResponse> loginApiCall(LoginPayloadModel loginPayLoad) async {
    try {
      var data = json.encode({
        "email": loginPayLoad.email,
        "password": loginPayLoad.password,
        "deviceInfo": {
          "deviceId": loginPayLoad.deviceInfo!.deviceId,
          "deviceType": loginPayLoad.deviceInfo!.deviceType,
          "deviceName": loginPayLoad.deviceInfo!.deviceName,
          "os": loginPayLoad.deviceInfo!.os,
          "appVersion": loginPayLoad.deviceInfo!.appVersion,
          "countryname": loginPayLoad.deviceInfo!.countryName
        }
      });

      Debug.printLog("🚀 Sending Login Payload: ${jsonEncode(data)}");

      var response = await dioClient!.dio.post('/login', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Debug.printLog("✅ Login Success: ${response.data}");
        return LoginModelResponse.fromJson(response.data);
      } else {
        String errorMessage = "An unknown error occurred";
        if (response.data is Map && response.data.containsKey("message")) {
          errorMessage = response.data["message"].toString();
        } else if (response.statusMessage != null) {
          errorMessage = response.statusMessage!;
        }
        Debug.printLog("❌ Login Failed: ${response.statusCode} - $errorMessage");
        throw Exception("Failed to Login: $errorMessage");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        Debug.printLog("Error Status Status: ${e.response?.data["status"]}");
        Debug.printLog("Error Status message: ${e.response?.data["message"]}");
        if (e.response?.statusCode == 404) {
          Debug.printLog("Resource not found! Handle 404 error here.");
        } else {
          Debug.printLog("Other Error: ${e.response?.data["message"]}");
        }
      } else {
        Debug.printLog("Dio Error1: ${e.message}");
      }
      rethrow;
    } catch (e) {
      Debug.printLog("❌ Error during Login: $e");
      rethrow;
    }
  }

  /// Add subscriptions API
  Future<SubscriptionModelResponse> addSubscriptionsApiCall(SubscriptionModelPayload addSubscriptionsPayLoad) async {
    try {
      var data = json.encode({
        "plan_name": addSubscriptionsPayLoad.planName,
        "plan": addSubscriptionsPayLoad.plan,
        "term": addSubscriptionsPayLoad.term,
        "amount": addSubscriptionsPayLoad.amount,
        "remarks": addSubscriptionsPayLoad.remarks,
        "isactive": addSubscriptionsPayLoad.isActive,
        "isDefault":addSubscriptionsPayLoad.isDefault,
        "starttime": addSubscriptionsPayLoad.startTime,
        "deviceInfo": {
          "deviceId": addSubscriptionsPayLoad.deviceInfo!.deviceId,
          "deviceType": addSubscriptionsPayLoad.deviceInfo!.deviceType,
          "deviceName": addSubscriptionsPayLoad.deviceInfo!.deviceName,
          "os": addSubscriptionsPayLoad.deviceInfo!.os,
          "appVersion": addSubscriptionsPayLoad.deviceInfo!.appVersion,
          "countryname": addSubscriptionsPayLoad.deviceInfo!.countryName
        }
      });

      Debug.printLog("🚀 Sending Login Payload: ${jsonEncode(data)}");

      var response = await dioClient!.dio.post('/subscriptions/plans', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Debug.printLog("✅ Add Subscriptions Success: ${response.data}");
        return SubscriptionModelResponse.fromJson(response.data);
      } else {
        String errorMessage = "An unknown error occurred";
        if (response.data is Map && response.data.containsKey("message")) {
          errorMessage = response.data["message"].toString();
        } else if (response.statusMessage != null) {
          errorMessage = response.statusMessage!;
        }
        Debug.printLog("❌ Add Subscriptions Failed: ${response.statusCode} - $errorMessage");
        throw Exception("Failed to Add Subscriptions: $errorMessage");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        Debug.printLog("Error Status Status: ${e.response?.data["status"]}");
        Debug.printLog("Error Status message: ${e.response?.data["message"]}");
        if (e.response?.statusCode == 404) {
          Debug.printLog("Resource not found! Handle 404 error here.");
        } else {
          Debug.printLog("Other Error: ${e.response?.data["message"]}");
        }
      } else {
        Debug.printLog("Dio Error1: ${e.message}");
      }
      rethrow;
    } catch (e) {
      Debug.printLog("❌ Error during Add Subscriptions: $e");
      rethrow;
    }
  }
}
