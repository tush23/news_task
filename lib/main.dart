import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/api/provider/api_provider.dart';
import 'app/constants/strings.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put<ApiProvider>(
    ApiProvider(),
  );
  runZonedGuarded<Future<void>>(
        () async {
          runApp(
            GetMaterialApp(
              title: "Application",
              theme: Get.theme,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            ),
          );
    },
        (dynamic error, StackTrace stackTrace) {
      print('ERRRORR $error $stackTrace');
      Get.defaultDialog(
          title: kWentWrong,
          middleText: '$kContactAdmin',
          barrierDismissible: false);
    },
  );

}
