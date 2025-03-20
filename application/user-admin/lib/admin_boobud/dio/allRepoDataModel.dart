import 'package:flutter/material.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginModelResponse.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginPayloadModel.dart';
import 'package:medicare/admin_boobud/dio/dioclient.dart';
import 'package:medicare/admin_boobud/dio/repository.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelPayload.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelResponce.dart';
import 'package:medicare/admin_boobud/uttils/env.dart';

class AllRepoDataModel {

  ///Login Api
  Future<LoginModelResponse> loginCallAPI(BuildContext context,LoginPayloadModel loginPayLoad) {
    DioClient dioClient = DioClient(context,isJson: true);
    return Repository(dioClient).loginApiCall(loginPayLoad);
  }

  ///Add Subscription Api
  Future<SubscriptionModelResponse> addSubscriptionsApiCallAPI(BuildContext context,SubscriptionModelPayload addSubPayLoad) {
    DioClient dioClient = DioClient(context,isJson: true,baseUrl: Env.baseUrl2,useToken: true);
    return Repository(dioClient).addSubscriptionsApiCall(addSubPayLoad);
  }

}