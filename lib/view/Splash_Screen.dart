import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../controller/database_controller.dart';
import 'LoginPage.dart';
import 'ShowData.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static Database? db;
  static SharedPreferences? sp;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  database controller = Get.find<database>();
  @override
  void initState() {
    super.initState();
    getpred();
    Future.delayed(Duration(seconds: 3), () {
      controller.Status = (SplashScreen.sp!.getBool("Status")) ?? false;
      if (!(controller.Status)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return showData();
              },
            ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("Animation/animation.json")),
    );
  }
  void getpred()async {
    SplashScreen.sp=await SharedPreferences.getInstance();
    SplashScreen.db =await controller.createdatabase();
  }
}
