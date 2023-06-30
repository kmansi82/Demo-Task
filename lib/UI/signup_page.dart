import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mydemo/Controller/signup_controller.dart';
import 'package:mydemo/UI/login_screen.dart';
import 'package:mydemo/Utils/Common_input_form_field.dart';
import 'package:mydemo/Utils/app_constant.dart';
import 'package:mydemo/Utils/form_validations.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {

  TextEditingController firstNameCTR = TextEditingController();
  TextEditingController lastNameCTR = TextEditingController();
  TextEditingController userNameCTR = TextEditingController();
  TextEditingController emailCTR = TextEditingController();
  TextEditingController passwordCTR = TextEditingController();
  TextEditingController confirmPasswordCTR = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final watch = ref.watch(signupPageController);

    });
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
    final watch = ref.watch(signupPageController);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Text('Registration'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                /// First Name Text Field
                CommonInputFormField(
                  textEditingController: firstNameCTR,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: (value) {
                    return validateText(value, 'First name is required.');
                  },
                  placeholderText: "First Name",
                ),

                /// Last Name Text Field
                CommonInputFormField(
                  textEditingController: lastNameCTR,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: (value) {
                    return validateText(value, 'Last is required.');
                  },
                  placeholderText: "Last Name",
                ),

                /// User Name Text Field
                CommonInputFormField(
                  textEditingController: userNameCTR,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: (value) {
                    return validateText(value, 'User name is required.');
                  },
                  placeholderText: "User Name",
                ),

                /// Email Address Text Field
                CommonInputFormField(
                  textEditingController: emailCTR,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: validateEmail,
                  placeholderText: "Email Address",
                  textInputType: TextInputType.emailAddress,
                ),

                /// Password Text Field
                CommonInputFormField(
                  textEditingController: passwordCTR,
                  obscureText: true,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: (value) {
                    return validateText(value, 'Password is required.');
                  },
                  placeholderText: "Password",
                ),

                /// Confirm Password Text Field
                CommonInputFormField(
                  textEditingController: confirmPasswordCTR,
                  obscureText: true,
                  scrollPadding: EdgeInsets.only(bottom: 125.h),
                  validator: (value) {
                    if(value == null || value == ''){
                      return 'Confirm password is required.';
                    }
                    else if(value != passwordCTR.text){
                     return 'Password and confirm password didn\'t matched.';
                    } else {
                      return null;
                    }
                  },
                  placeholderText: "Confirm Password",
                  textInputAction: TextInputAction.done,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green
                  ),
                  onPressed: (){
                      var result = _formKey.currentState?.validate();
                      if (result!) {
                        hideKeyboard(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()));
                      }
                      },
                    child: Text('Sign Up'))
              ],
            ),
          ),
        ),
        // child: Column(
        //   children: [
        //     InkWell(
        //       onTap: () async {
        //         watch.update();
        //         await watch.postUser();
        //         // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const PageOne()));
        //       },
        //       child: Container(
        //         // height: 100.h,
        //         //   width: 20.w,
        //         color: Colors.amberAccent,
        //         child: Column(
        //           children: [
        //             Text(watch.num.toString()),
        //             Text(watch.remo?.data?[0].cityName??''),
        //             Text(watch.postModel?.data?.id.toString()??''),
        //             Text(watch.postModel?.data?.name??'')
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
