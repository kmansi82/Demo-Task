import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mydemo/UI/verify_otp.dart';
import 'package:mydemo/Utils/Common_input_form_field.dart';
import 'package:mydemo/Utils/app_constant.dart';
import 'package:mydemo/Utils/form_validations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  TextEditingController userNameOrEmailCTR = TextEditingController();
  TextEditingController passwordCTR = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  ///Dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              /// UserName or Email Text Field
              CommonInputFormField(
                textEditingController: userNameOrEmailCTR,
                scrollPadding: EdgeInsets.only(bottom: 125.h),
                validator: (value) {
                  return validateText(value, 'Username or email is required.');
                },
                placeholderText: "UserName or Email",
              ),
              /// Password Text Field
              CommonInputFormField(
                textEditingController: passwordCTR,
                obscureText: true,
                scrollPadding: EdgeInsets.only(bottom: 125.h),
                validator: (value) {
                  return validateText(value, 'Password is required.');
                },
                textInputAction: TextInputAction.done,
                placeholderText: "Password",
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: green
                  ),
                  onPressed: (){
                    var result = _formKey.currentState?.validate();
                    if (result!) {
                      hideKeyboard(context);

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const VerifyOtp()));
                    }
                  },
                  child: Text('Sign Up'))


            ],
          ),
        ),
      ),
    );
  }
}
