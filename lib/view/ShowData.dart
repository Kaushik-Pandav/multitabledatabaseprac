import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/contactModel.dart';

import '../controller/database_controller.dart';
import '../model/updateData.dart';
import 'LoginPage.dart';
import 'Splash_Screen.dart';
import 'addnewContact.dart';

class showData extends StatefulWidget {
  showData({super.key});

  @override
  State<showData> createState() => showDataState();
}

class showDataState extends State<showData> {
  database controller = Get.find<database>();
  TextEditingController c = TextEditingController();
  bool search = false;
  List<Contactmodel> searchList = [];
  List<Contactmodel> alldata = [];

  @override
  void initState() {
    super.initState();
    create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          search
              ? AppBar(
                title: TextField(
                  onChanged: (value) {
                    searchList = [];
                    setState(() {
                      for (int i = 0; i < alldata.length; i++) {
                        if (alldata[i].name.toLowerCase().contains(
                              value.toLowerCase(),
                            ) ||
                            alldata[i].number.contains(value)) {
                          searchList.add(alldata[i]);
                        }
                      }
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchList = alldata;
                          search = false;
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ),
              )
              : AppBar(
                backgroundColor: Colors.blue,
                title: Text(
                  "Contacts",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchList = alldata;
                        search = true;
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
      body: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: searchList.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Update"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {

                              database controller = Get.find<database>();
                              controller.contactnameController.text = searchList[index].name;
                              controller.contactnumberController.text = searchList[index].number;



                              return Updatedata(
                                id: searchList[index].id,
                                name: searchList[index].name,
                                number: searchList[index].number,
                              );
                            },
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                        onTap: () {
                          controller
                              .deletecontact(
                                SplashScreen.db!,
                                id: searchList[index].id,
                              )
                              .then((value) {
                                create();
                              });
                        },
                      ),
                    ];
                  },
                ),
                title: Text(searchList[index].name),
                subtitle: Text(searchList[index].number),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: ListTile(
                leading: Image.asset("Animation/avtar.jpg"),
                title: Text(SplashScreen.sp!.getString("Username")??" ", style: TextStyle(fontSize: 25)),
              ),
            ),
            Spacer(),
            ListTile(
              splashColor: Colors.blue,
              leading: Icon(Icons.logout, size: 35, color: Colors.black),
              title: Text(
                "Logout",
                style: TextStyle(
                  height: 3,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                {
                  SplashScreen.sp!.setBool("Status", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return addNewContact(id: SplashScreen.sp!.getInt("userid")??0);
          },);
        },
        child: Icon(Icons.add, size: 55, color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 10,
      ),
    );
  }

  Future<void> create() async {
    SplashScreen.db = await controller.createdatabase();
    controller.showdata(SplashScreen.db!, userid: SplashScreen.sp!.getInt("userid")??0).then((value) {
      alldata = value;
      searchList = alldata;
    });
    setState(() {
    });
  }
}
