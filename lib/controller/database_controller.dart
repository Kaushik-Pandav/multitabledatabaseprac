import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/contactModel.dart';

class database extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController contactnameController = TextEditingController();
  TextEditingController contactnumberController = TextEditingController();
  bool Status = false;
  String user = "";
  String pass = "";

  Future<Database> createdatabase() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'newdataa.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,number TEXT,email TEXT,password TEXT)",
        );
        db.execute(
          "CREATE TABLE contact(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,number TEXT,userid INTEGER)",
        );
      },
    );
    return database;
  }

  void insertuser(Database db) {
    String name = nameController.text.trim();
    String number = numberController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String sql =
        "INSERT INTO user('name','number','email','password') VALUES ('$name','$number','$email','$password')";
    db.rawInsert(sql);
  }

  Future<void> insertcontact(Database db, {required int userid}) async {
    String contactname = contactnameController.text.trim();
    String contactnumber = contactnumberController.text.trim();
    String sql =
        "INSERT INTO contact('name','number','userid') VALUES ('$contactname','$contactnumber',$userid)";
    int a = await db.rawInsert(sql);
  }

  Future<void> updatecontact(
    Database db, {
    required int id,
    required String name,
    required String number,
  }) async {
    String sql =
        "UPDATE contact SET name='$name', number ='$number' WHERE id=$id";
    int a = await db.rawUpdate(sql);
  }

  Future<void> deletecontact(Database db, {required int id}) async {
    String sql = "DELETE FROM contact WHERE id=$id";
    int aaa = await db.rawDelete(sql);
  }

  Future<List> check(
    Database db, {
    required String username,
    required String password,
  }) async {
    String sql =
        "SELECT id,name,number,email,password FROM user WHERE (email='$username' OR number='$username') AND password='$password'";
    List credentials = await db.rawQuery(sql);
    return credentials;
  }

  Future<List<Contactmodel>> showdata(
    Database db, {
    required int userid,
  }) async {
    String sql = "SELECT * FROM contact WHERE userid=$userid";
    List contacts = await db.rawQuery(sql);
    List<Contactmodel> datalist = [];
    for (int i = 0; i < contacts.length; i++) {
      Contactmodel model = Contactmodel(
        contacts[i]["id"],
        contacts[i]["name"],
        contacts[i]["number"],
        contacts[i]["userid"],
      );
      datalist.add(model);
    }
    return datalist;
  }
}
