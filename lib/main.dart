import 'package:flutter/material.dart';
import 'package:sqflite_login/sqlite_login/admin_home.dart';
import 'package:sqflite_login/sqlite_login/registration.dart';
import 'package:sqflite_login/sqlite_login/user_home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:RegistrationPageSQLite(),debugShowCheckedModeBanner: false,
    );
  }
}