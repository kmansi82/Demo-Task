import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Hide Keyboard
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

const Color green = Color(0xff3CB043);
int appUsageSeconds = 300;
int otpTimer = 30;
int openPromptTiming = 30;


String getUser(int pageNo) => 'https://reqres.in/api/users?page=$pageNo';
String addUser = 'https://reqres.in/api/users';
String deleteUser(int userId) => 'https://reqres.in/api/users/$userId';
String editUser(int userId) => 'https://reqres.in/api/users/$userId';


/// Message Dialog
showMessageDialog(
    BuildContext context, bool barrierDismissible, bool showSecondBtn, String message, Function() delayedAction, Function()? didDismiss, Function()? didDismiss2) {
  return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      // barrierColor: AppColors.bg1A2D3170,
      builder: (context) {
        Future.delayed(Duration(seconds: openPromptTiming), () {
          delayedAction();
        });
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
          child: Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(16.sp),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5))),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  // height: ScreenUtil().setHeight(220),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 65.w, vertical: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                                if (didDismiss != null) {
                                  Future.delayed(const Duration(milliseconds: 80),
                                          () {
                                        didDismiss();
                                      });
                                }
                              }, child: Text(showSecondBtn? 'No': 'Ok')),
                            ),
                            Visibility(
                              visible: showSecondBtn,
                              child: Expanded(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      width: 100.w,
                                      child: ElevatedButton(onPressed: (){
                                        Navigator.pop(context);
                                        if (didDismiss != null) {
                                          Future.delayed(const Duration(milliseconds: 80),
                                                  () {
                                                didDismiss2!();
                                              });
                                        }
                                      }, child: Text('Yes')),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
