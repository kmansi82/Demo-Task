
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydemo/dio_client.dart';
import 'package:mydemo/model/model.dart';
import 'package:mydemo/model/postDatamodel.dart';

final signupPageController = ChangeNotifierProvider.autoDispose((ref)=> SignUpPageController());
class SignUpPageController extends ChangeNotifier{

  int num = 0;
  update(){
    num ++;
    notifyListeners();
  }



  String strUrl = 'http://cloud1.kodyinfotech.com:7000/actiday/public/api/customer/cities/1/15';

  DataResponseModel? remo;
  Future<void> getUser() async {

    try {
      Response response = await DioClient().dio.get(
        strUrl
      );

      print('User created: ${response.data}');

      remo = dataResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $remo");
    print("RES: ${remo?.data?.length}");
    notifyListeners();
  }


  PostDataResponseModel? postModel;
  Future<void> postUser() async {
    postModel = null;

    Map<String, dynamic>? headers = {
      "Accept": "application/json",
      "Accept-Language": 'en',
    };

    if(/*token != ""*/1==1){
      // headers.addAll({"Authorization": "Bearer $token"});
      headers.addAll({"Authorization": "Bearer dolar token"});
    }

    var dioAuth = Dio(BaseOptions(headers: headers));
    // dioAuth.interceptors.clear();
    // dioAuth.interceptors.add(CacheInterceptor(context, dio, CacheInterceptor.apiPOST));
    // dioAuth.interceptors.add(DioLogger());
    Map<String, dynamic> data = ({
      "email": "john@gmail.com",
      "password": "Kody@123"
    });
    try {
      Response response = await DioClient().dio.post(
        'http://cloud1.kodyinfotech.com:7000/actiday/public/api/vendor/signin', data: data
      );

      print('User created: ${response.data}');

      postModel = postDataResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $postModel");
    print("RES: ${postModel?.data?.id}");
    notifyListeners();
  }



  PostDataResponseModel? tokenModel;
  Future<void> tokenUser() async {
    postModel = null;

    Map<String, dynamic>? headers = {
      "Accept": "application/json",
      "Accept-Language": 'en',
    };

    if(/*token != ""*/1==1){
      // headers.addAll({"Authorization": "Bearer $token"});
      headers.addAll({"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzQ1NmU5YmQ4ZTgxY2M5YWEzMDZiZjZiYTJlN2Q0OWVmYzdkOTM4MWI1ODdhZGRiMTg2OTIwNWJhYzRjODQxMGQ2ZDY2ZWY0YjQzYzJmMmQiLCJpYXQiOjE2ODgxMDg3ODMsIm5iZiI6MTY4ODEwODc4MywiZXhwIjoxNzE5NzMxMTgzLCJzdWIiOiIyNiIsInNjb3BlcyI6W119.kV5MaKJyF0WEmLCBHQVdmMA8WKEvSYJvgRdc2w6q6wSiRFkWEm_3b8tr3XGe_oUB9rCGbOc_HNSaKi55IZAdyN3-rAHLpSkXplifprJLGEToJDTf6SZ4EfeXNShlrZPAW33u_VT9jTs1DC4fPuINfQ_vWBjsw444wlNeszjgpHA6gIB48Oe3XnpSr5mm6Fzi4_5V9RCTgk318Ns4vMVhzOrml79kOudn0qFTQfMyVJQhqNc3tUhvbtyjQxe6XH_dKCTJpukScX3EKsMbcwAut3xd-JoATld3ThBPjjTAl4lQO8xaDpVdw9JZKKU-yANMmdMeyST2LcvcHuzKqPnfJslAfDc0Na6NyHd_aiY2ZVTyeoZTSbpGMqBZXep4Jn19lLX7ro_u6MmSNvNdFAjFjBb5_Y4jXL4dNg32Pv20doZE-76yx81YtfN3F_vAsFhyyEfXlfTRlu_u9Yg3UWhPn-ZZPtJXFAfafWiy_q6NDGP7oIh0uPs0rb59CeBknSiad6hubHbDkEA1ldFIxngNWiLHIW9UWtQ2cIZjl0KMbK6fUERTGjW0_Tz6Bk2b82LBsq1_ewl9OwvjZTW4axDZma79pUa3ZuVQNG9u0TewCeRZguqOfYBVu1nniyNhkA5qM685d1jJ-BJTnMqCFxlvbZTMvb75hWOit3856"});
    }

    var dioAuth = Dio(BaseOptions(headers: headers));
    // dioAuth.interceptors.clear();
    // dioAuth.interceptors.add(CacheInterceptor(context, dio, CacheInterceptor.apiPOST));
    // dioAuth.interceptors.add(DioLogger());
    Map<String, dynamic> data = ({
      "email": "john@gmail.com",
      "password": "Kody@123"
    });
    try {
      Response response = await dioAuth.post(
        'http://cloud1.kodyinfotech.com:7000/actiday/public/api/vendor/signin', data: data
      );

      print('User created: ${response.data}');

      postModel = postDataResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $postModel");
    print("RES: ${postModel?.data?.id}");
    notifyListeners();
  }


}