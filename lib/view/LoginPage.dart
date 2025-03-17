import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/database_controller.dart';
import 'ShowData.dart';
import 'Splash_Screen.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  database controller = Get.find<database>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Login", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            tf(controller.nameController, "Username"),
            tf(controller.passwordController, "Password"),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () async {
                  String user = controller.nameController.text.trim();
                  String pass = controller.passwordController.text.trim();
                  login(username: user, password: pass);
                },
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SighUp();
                    },
                  ),
                );
              },
              child: Text('New User? Sighup Here'),
            ),
          ],
        ),
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

  Future<void> login({
    required String username,
    required String password,
  }) async {
    List data = await controller.check(
      SplashScreen.db!,
      username: username,
      password: password,
    );
    if ((username == data[0]['email'] || username == data[0]['number']) &&
        password == data[0]['password']) {
      SplashScreen.sp!.setBool("Status", true);
      controller.Status=(SplashScreen.sp!.getBool("Status"))??false;
      SplashScreen.sp!.setString("Username", username);
      SplashScreen.sp!.setString("Password", password);
      SplashScreen.sp!.setInt("userid", data[0]["id"]);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return showData();
          },
        ),
      );
    }
  }
}
