// ignore_for_file: prefer_const_constructors

import 'package:dummy_12/views/pages/home_page.dart';
import 'package:dummy_12/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage login = LocalStorage('loginData');
void main() {
  login.ready;
  runApp(Cracker());
}

class Cracker extends StatelessWidget {
  const Cracker({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    return login.getItem('login') != null
        ? MaterialApp(
          debugShowCheckedModeBanner: false,
            home: HomePage(),
          )
        : MaterialApp(
          debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
  }
  
}
