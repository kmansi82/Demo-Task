import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mydemo/Controller/verify_otp_controller.dart';
import 'package:mydemo/UI/dashboard.dart';
import 'package:mydemo/Utils/app_constant.dart';
import 'package:mydemo/Utils/form_validations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtp extends ConsumerStatefulWidget {


  const VerifyOtp({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyOtp> createState() => _VerifyOtpMobileState();
}

class _VerifyOtpMobileState extends ConsumerState<VerifyOtp> {
  ///form key
  final _formKey = GlobalKey<FormState>();

  ///TextEditing Controller
  TextEditingController otpCtr = TextEditingController();

  ///timer variable
  late Timer timer;

  ///init override
  @override
  void initState() {
    super.initState();

    ///otp timer
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final verifyOtpWatch = ref.watch(verifyController);
      verifyOtpWatch.disposeController();
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        verifyOtpWatch.otpVerifyTimer();

      });
    });
  }

  ///timer dispose
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(Navigator.of(context).userGestureInProgress);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: green,
            title: const Text('Verify Otp'),
          ),
          body: _bodyWidget(),
        ),
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final verifyOtpWatch = ref.watch(verifyController);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: ListView(
        children: [
          Text(
            'OTP Verify',
            style: TextStyle(fontSize: 16.sp)
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 71.h,
            child: Form(
              key: _formKey,
              child: PinCodeTextField(
                autoFocus: true,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewInsets.bottom),
                autovalidateMode: AutovalidateMode.disabled,
                appContext: context,
                controller: otpCtr,
                pastedTextStyle: TextStyle(fontSize: 19.sp),
                length: 6,
                animationType: AnimationType.fade,
                errorTextMargin: EdgeInsets.only(top: 10.h),
                validator: (str) {

                  if(otpCtr.text.isNotEmpty||otpCtr.text.isEmpty){
                    if((verifyOtpWatch.enableResend&&otpCtr.text.isNotEmpty)){
                      validateOtp(str, clearValidation: true);
                    }else{
                      return validateOtp(str);
                    }
                  }
                },
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(25.r),
                    activeColor: Colors.black,
                    fieldHeight: 40.h,
                    fieldWidth: 40.w,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    selectedColor: Colors.black),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {},
                /*beforeTextPaste: (text) {
                  return true;
                },*/
              ),
            ),
          ),
          SizedBox(
            height: 31.h,
          ),
          Row(
            children: [
              Text(
                  'Code expire in: ',
                  style: TextStyle(fontSize: 16.sp)
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                verifyOtpWatch.secondsRemaining < 10
                    ? '00:0${verifyOtpWatch.secondsRemaining}'
                    : '00:${verifyOtpWatch.secondsRemaining}',
                style: TextStyle(fontSize: 16.sp)
              )
            ],
          ),
          SizedBox(
            height: 121.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Didn\'t received code?',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey)
              ),
              SizedBox(
                width: 3.w,
              ),
              InkWell(
                onTap: (){
                  if(verifyOtpWatch.enableResend){
                    otpCtr.clear();
                    ///Start Timer again
                    FocusManager.instance.primaryFocus?.unfocus();
                    verifyOtpWatch.disposeController(isNotify: true);
                  }
                },
                child: Text(
                  'Resend',
                  style: TextStyle(
                      color: verifyOtpWatch.enableResend
                          ? Colors.red
                          : Colors.grey,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(
            height: 68.h,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: green
              ),
              onPressed: (){
                var result = _formKey.currentState?.validate();
                if (result!) {
                  hideKeyboard(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DashBoard()));
                }
              },
              child: Text('Verify'))
        ],
      ),
    );
  }
}
