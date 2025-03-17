import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/database_controller.dart';
import 'view/Splash_Screen.dart';

void main()
{
  Get.put(database());
  runApp(GetMaterialApp(home: SplashScreen(),));
}

