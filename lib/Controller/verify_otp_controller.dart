import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydemo/Utils/app_constant.dart';


final verifyController = ChangeNotifierProvider.autoDispose((ref)=> VerifyController());

class VerifyController extends ChangeNotifier {



  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    secondsRemaining = otpTimer;
    enableResend = false;
    currentText = '';
    otpComplete = false;
    isLoading = false;
    isLoadingSubmitData = false;
    // verifyMobileOtpResponseModel = null;
    // resendOtpResponseModel = null;
    if (isNotify) {
      notifyListeners();
    }
  }

  ///variables for timer
  int secondsRemaining = otpTimer;
  bool enableResend = false;

  ///current text in otp field
  String currentText = '';

  bool otpComplete = false;

  void otpVerifyTimer() {
    if (secondsRemaining != 0) {
      secondsRemaining--;
    } else {
      enableResend = true;
    }
    notifyListeners();
  }

  void resendCode() {
    //other code here

    secondsRemaining = otpTimer;
    enableResend = false;
    notifyListeners();
  }

  void changeOtpField(value) {
    currentText = value;
    notifyListeners();
  }


  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false; ///For general purpose
  bool isLoadingSubmitData = false; ///For submit button purpose

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateIsLoadingSubmitData(bool value) {
    isLoadingSubmitData = value;
    notifyListeners();
  }
}
