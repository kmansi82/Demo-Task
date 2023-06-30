import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mydemo/Controller/dashboard_controller.dart';
import 'package:mydemo/UI/login_screen.dart';
import 'package:mydemo/Utils/Common_input_form_field.dart';
import 'package:mydemo/Utils/app_constant.dart';
import 'package:mydemo/Utils/form_validations.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {

  ///timer variable
  late Timer appUsageTimer;

  /// scroll controller
  ScrollController scrollController = ScrollController();

  TextEditingController nameCTR = TextEditingController();
  TextEditingController jobCTR = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final dashBoardWatch = ref.watch(dashBoardController);

      dashBoardWatch.disposeController(isNotify: true);
      dashBoardWatch.getUserData(context);
      scrollController.addListener(() {
        print("comeeeee");
        if (dashBoardWatch.isHasMorePage) {
          if (scrollController.position.maxScrollExtent == (scrollController.position.pixels)) {
            if (dashBoardWatch.userListResponseModel?.page != dashBoardWatch.userListResponseModel?.totalPages && !dashBoardWatch.isLoadingPagination) {
              dashBoardWatch.getUserData(context);
            }
          }
        }
      });

      startUsageTimer();


    });
  }

  ///Dispose
  @override
  void dispose() {
    // TODO: implement dispose
    appUsageTimer.cancel();

    super.dispose();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    final dashBoardWatch = ref.watch(dashBoardController);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: green,
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                      itemCount: dashBoardWatch.userData.length ,
                      itemBuilder: (context, index){
                        final data = dashBoardWatch.userData[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: green.withOpacity(0.2)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      margin: EdgeInsets.symmetric(vertical: 20.h),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${index+1}.  ${data?.firstName} ${data?.lastName}',
                              style: TextStyle(fontSize: 16.sp)),
                          PopupMenuButton<int>(
                              onSelected: (int item) async {
                                switch (item) {
                                  case 1:
                                    {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(15.r),
                                            )),
                                        builder: (context) {

                                          nameCTR.text = dashBoardWatch.userData[index]?.firstName??'';
                                          /// NOTE: as user list has not job type i m passing lastname instead of that
                                          jobCTR.text = dashBoardWatch.userData[index]?.lastName??'';
                                          return bottomSheetWidget(context, true, dashBoardWatch.userData[index]?.id??0 );
                                        },
                                      );

                                      break;
                                    }
                                  case 2:
                                    {
                                      showMessageDialog(context,true, true,"You are you want to delete user?",(){}, () {

                                      }, (){
                                        dashBoardWatch.deleteUserData(dashBoardWatch.userData[index]?.id??0 );
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("User deleted successfully"),
                                          backgroundColor: green,
                                        ));

                                      });
                                      // ref.read(navigationStackController).push(NavigationStackItem.addAddress(
                                      //   location: '',
                                      //   isEditPage: true,
                                      //   navigateBackToAddProduct: false,
                                      //   addressData: widget.addressData,
                                      //   popCallBack: (result) async {
                                      //     if (result != null || result != '') {
                                      //       selectLocationWatch.disposeController(isNotify: true);
                                      //       selectLocationWatch.isAnythingUpdate = true;
                                      //       await selectLocationWatch.addressListApi(context);
                                      //     }
                                      //   },
                                      // ));
                                      break;
                                    }
                                }
                              },
                              offset: const Offset(0, 0),
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<int>>[
                                PopupMenuItem<int>(
                                  padding: const EdgeInsets.only(
                                      left: 10),
                                  height: 30.h,
                                  value: 1,

                                  child: const Text('Edit'),
                                ),
                                PopupMenuItem<int>(
                                  height: 30.h,
                                  padding: const EdgeInsets.only(
                                      left: 10),
                                  value: 2,

                                  child: const Text('Delete'),
                                ),

                              ],
                              child: Text("Action", style: TextStyle(fontSize: 16.sp, color: Colors.red),))
                        ],
                      ),
                    );
                  }),
                  Visibility(
                      visible: dashBoardWatch.isLoadingPagination,
                      child: const CircularProgressIndicator(color: green,)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green
                      ),
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              )),
                          builder: (context) {
                            nameCTR.text = '';
                            jobCTR.text = '';
                            return bottomSheetWidget(context, false,0);
                          },
                        );
                      },
                      child: const Text('Add New User'))

                ],
              ),
            ),
          ),),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: green),
                accountName: Text(
                  "Hi, Mansi Khatri",
                  style: TextStyle(fontSize: 18.sp),
                ),
                accountEmail: const Text("mansi@gmail.com"),
                currentAccountPictureSize: Size.square(50.r),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 30.sp, color: Colors.black),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text("Timer ${dashBoardWatch.minute} : ${dashBoardWatch.second}",style: TextStyle(fontSize: 16.sp,),)),


            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const LoginScreen()), (Route<dynamic> route) => false);

              },
            ),
          ],
        ),
      ), //Drawer
    );
  }


  ///Bottom Sheet
  Widget bottomSheetWidget(BuildContext context, bool isEdit, int? userId) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        hideKeyboard(context);
      },
      child: Consumer(builder: (context, ref, child) {
        final dashBoardWatch = ref.watch(dashBoardController);
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, left: 20.w, right: 20.w, top: 20.h),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Name or Email Text Field
                  CommonInputFormField(
                    scrollPadding: EdgeInsets.only(bottom: 125.h),
                    textEditingController: nameCTR,
                    validator: (value) {
                      return validateText(value, 'Name is required.');
                    },
                    placeholderText: "Name",
                  ),
                  /// Job Text Field
                  CommonInputFormField(
                    textEditingController: jobCTR,
                    scrollPadding: EdgeInsets.only(bottom: 125.h),
                    validator: (value) {
                      return validateText(value, 'Job is required.');
                    },
                    textInputAction: TextInputAction.done,
                    placeholderText: "Job",
                  ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green
                      ),
                      onPressed: () async {
                        var result = _formKey.currentState?.validate();
                        if (result!) {
                          hideKeyboard(context);
                          Navigator.pop(context);

                          if(isEdit){
                            dashBoardWatch.updateUser(nameCTR.text, jobCTR.text, userId??0);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("User is updated successfully"),
                              backgroundColor: green,
                            ));
                          }else{
                            dashBoardWatch.createUser(nameCTR.text, jobCTR.text);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("User is added successfully"),
                              backgroundColor: green,
                            ));
                          }

                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const VerifyOtp()));
                        }
                      },
                      child: const Text('Create User')),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void startUsageTimer() {
    final dashBoardWatch = ref.watch(dashBoardController);

    appUsageTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      dashBoardWatch.appUsageTimer();
      if(dashBoardWatch.remainingAppUsageSeconds == 0){
        appUsageTimer.cancel();
        showMessageDialog(context, false, false,  "You are using the application from past 5 mins, we are logging you out", (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const LoginScreen()), (Route<dynamic> route) => false);
          }, () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const LoginScreen()), (Route<dynamic> route) => false);
        }, (){});
      }
    });
  }

}
