import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_task/app/constants/strings.dart';





class ApiHandler {
  static final ApiHandler _singleton = ApiHandler._internal();

  factory ApiHandler() {
    return _singleton;
  }

  ApiHandler._internal();
  // ApiHandler({this.errorString, this.retryPressed});

  noLocationDialog(Function onOkPress)=>Get.defaultDialog(
      title: kLocationRequired,
      barrierDismissible: false,
      confirm: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        width: 80,
        height: 40,
        child: MaterialButton(
            onPressed: onOkPress, child: Text('Ok',style: Get.textTheme.button.copyWith(color: Colors.white),)),
      ),
      middleText: kLocationDesc);

  Future<AlertDialog> loading() => showDialog(
      barrierDismissible: false,
      builder:(ctx)=> Center(
          child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: 60,
              height: 60,
              child: CircularProgressIndicator(strokeWidth: 1.5,semanticsLabel: "Loadinf",))),
      context: Get.context);

  Widget errorRetry({@required String error, Function retry})=>Center(
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error),
        SizedBox(height: 8,),
        TextButton(onPressed: retry, child: Text('Retry'))
      ],
    ),
  );

  void errorSnackBar(String msg)=>Get.rawSnackbar(snackPosition: SnackPosition.BOTTOM,message: msg,title: 'Error!',duration: Duration(seconds: 3));
  void noInternetSnackBar()=>Get.rawSnackbar(snackPosition: SnackPosition.BOTTOM,message: "Please check your Internet Connection!",title: 'No Internet');
  void getInternetSnackBar()=>Get.rawSnackbar(snackPosition: SnackPosition.BOTTOM,message: "Internet connection has been restored",title: 'Internet Restored');

}
