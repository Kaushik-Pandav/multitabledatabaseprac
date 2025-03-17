import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/view/ShowData.dart';

import '../controller/database_controller.dart';
import 'Splash_Screen.dart';

class addNewContact extends StatefulWidget {
  const addNewContact({
    super.key, required this.id,
  });
  final int id;
  @override
  State<addNewContact> createState() => _addNewContactState();
}

class _addNewContactState extends State<addNewContact> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    database controller = Get.find<database>();
    controller.contactnumberController.text="";
    controller.contactnameController.text="";
    return AlertDialog(
      alignment: Alignment.center,
      actions: [
        Container(
          alignment: Alignment.center,
          height: (query.size.height) * 0.27,
          width: (query.size.width) * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              field(controller.contactnameController, name: "Name"),
              field(controller.contactnumberController, name: "Number"),
              Container(
                padding: EdgeInsets.only(
                  left: 35,
                  right: 35,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),onTap: () {
                    controller.insertcontact(SplashScreen.db!, userid: widget.id).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return showData();
                      },));
                    },);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget field(TextEditingController c, {required String name}) {
    return TextField(
      decoration: InputDecoration(
        labelText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          gapPadding: 3,
        ),
      ),
      controller: c,
    );
  }
}
