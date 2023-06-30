import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydemo/Utils/app_constant.dart';
import 'package:mydemo/dio_client.dart';
import 'package:mydemo/model/create_user_response_model.dart';
import 'package:mydemo/model/update_user_response_model.dart';
import 'package:mydemo/model/user_list_response_model.dart';


final dashBoardController = ChangeNotifierProvider.autoDispose((ref)=> DashBoardController());

class DashBoardController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    remainingAppUsageSeconds = appUsageSeconds;
    isLoading = false;
    promptTiming = openPromptTiming;
    userListResponseModel = null;
    isLoadingPagination = false;
    minute = '';
    second = '';
    userData = [];
    if (isNotify) {
      notifyListeners();
    }
  }

  ///variables for timer
  int remainingAppUsageSeconds = appUsageSeconds;
  int promptTiming = openPromptTiming;

  String? minute ;
  String? second ;
   appUsageTimer() {
    if (remainingAppUsageSeconds != 0) {
      remainingAppUsageSeconds--;
    }

    int sec = remainingAppUsageSeconds % 60;
    int min = (remainingAppUsageSeconds / 60).floor();
    minute = min.toString().length <= 1 ? "0$min" : "$min";
    second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    print('$minute : $second');

    notifyListeners();
  }

  updatePromptTimer() {
    if (promptTiming != 0) {
      promptTiming--;
    }
    notifyListeners();
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  bool isLoadingPagination = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// loading for pagination
  void isLoadingForPaginationUpdate(bool value) {
    isLoadingPagination = value;
    notifyListeners();
  }

  /// get user data
  bool isHasMorePage = false;
  List<UserData?> userData = [];
  UserListResponseModel? userListResponseModel;
  Future<void> getUserData(BuildContext context) async {
    int pageNo = 1;
    if (isHasMorePage) {
      pageNo = (userListResponseModel?.page ?? 1) + 1;
    } else {
      userListResponseModel = UserListResponseModel();
    }
    (pageNo > 1) ? isLoadingForPaginationUpdate(true) : updateLoadingStatus(true);

    if (pageNo == 1) {
      userData.clear();
    }

    try {
      Response response = await DioClient().dio.get(getUser(pageNo));
      print("Come here");
      print("${userListResponseModel?.data}");
      print('User created: ${response.data}');

      userListResponseModel = userListResponseModelFromJson(response.toString());
      if (userListResponseModel?.data != null && userListResponseModel!.data!.isNotEmpty) {
        isHasMorePage = ((userListResponseModel?.totalPages ?? 1) > (userListResponseModel?.page ?? 1));

        // print("Come here");
        userData.addAll(userListResponseModel?.data ?? []);

      }

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $userListResponseModel");
    print("RES: ${userListResponseModel?.data?.length}");
    notifyListeners();
  }


  /// create user data
  CreateUserResponseModel? createUserResponseModel;
  Future<void> createUser(String name, String job) async {
    createUserResponseModel = null;

    Map<String, dynamic> data = ({
        "name": name,
        "job": job
    });
    try {
      Response response = await DioClient().dio.post(
          addUser, data: data
      );

      print('Add User: ${response.data}');

      createUserResponseModel = createUserResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $createUserResponseModel");
    print("RES: ${createUserResponseModel?.name}");
    notifyListeners();
  }


  /// update user data
  UpdateUserResponseModel? updateUserResponseModel;
  Future<void> updateUser(String name, String job, int userId) async {
    updateUserResponseModel = null;

    Map<String, dynamic> data = ({
      "name": name,
      "job": job
    });
    try {
      Response response = await DioClient().dio.put(
          editUser(userId), data: data
      );

      print('Add User: ${response.data}');

      updateUserResponseModel = updateUserResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $updateUserResponseModel");
    print("RES: ${updateUserResponseModel?.name}");
    notifyListeners();
  }

  /// Delete user data
  // UpdateUserResponseModel? updateUserResponseModel;
  Future<void> deleteUserData(int userId) async {
    // updateUserResponseModel = null;

    try {
      Response response = await DioClient().dio.delete(
          editUser(userId),
      );

      print('Delete User: ${response.data}');

      // updateUserResponseModel = updateUserResponseModelFromJson(response.toString());

    } catch (e) {
      print('Error creating user: $e');
    }

    print("RES: $updateUserResponseModel");
    print("RES: ${updateUserResponseModel?.name}");
    notifyListeners();
  }


}


