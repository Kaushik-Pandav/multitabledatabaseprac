import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/database_controller.dart';
import '../view/ShowData.dart';
import '../view/Splash_Screen.dart';

class Updatedata extends StatefulWidget {
  const Updatedata({
    super.key,
    required this.id,
    required this.name,
    required this.number,
  });

  final int id;
  final String name;
  final String number;

  @override
  State<Updatedata> createState() => _UpdatedataState();
}

class _UpdatedataState extends State<Updatedata> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    database controller = Get.find<database>();

    return AlertDialog(
      alignment: Alignment.center,
      actions: [
        Container(
          alignment: Alignment.center,
          height: (query.size.height) * 0.35,
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
                  bottom: 3,
                  top: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  onTap: () {
                    String updatename =
                        controller.contactnameController.text.trim();
                    String updatenum =
                        controller.contactnumberController.text.trim();
                    controller
                        .updatecontact(
                          SplashScreen.db!,
                          name: updatename,
                          number: updatenum,
                          id: widget.id,
                        )
                        .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return showData();
                              },
                            ),
                          );
                        });
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
