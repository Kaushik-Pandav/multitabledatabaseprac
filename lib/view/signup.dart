import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/view/LoginPage.dart';

import '../controller/database_controller.dart';
import 'ShowData.dart';
import 'Splash_Screen.dart';

class SighUp extends StatefulWidget {
  const SighUp({super.key});

  @override
  State<SighUp> createState() => _SighUpState();
}

class _SighUpState extends State<SighUp> {
  database c = Get.find<database>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'SignUp',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          tf(c.nameController, "Name"),
          tf(c.numberController, "Mobile NO"),
          tf(c.emailController, "Email"),
          tf(c.passwordController, "Password"),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(3),
            ),
            child: InkWell(
              onTap: () {
                c.insertuser(SplashScreen.db!);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                },));
              },
              child: Center(
                child: Text(
                  'SignUp',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tf(TextEditingController c, String name) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      height: 70,
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
