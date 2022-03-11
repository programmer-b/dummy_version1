// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:dummy_12/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dummy_12/model/utils.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import 'package:dummy_12/model/auth/login/login_error.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dummy_12/model/auth/login/login_success.dart';

import 'dart:convert';
import 'dart:io';

final LocalStorage login = new LocalStorage('loginData');

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var username_error;
  var password_error;

  GlobalKey<FormState> loginFormState = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    ProgressDialog progress = ProgressDialog(context);
    progress.style(
        message: "Authenticating...",
        messageTextStyle: TextStyle(fontSize: 14, color: Colors.white),
        backgroundColor: Colors.indigo);

    Future<bool> setUppApplications() async {
      String? token = LoginSuccess.fromJson(jsonDecode(login.getItem('login')))
          .dataPayload!
          .data!
          .token;
      Uri uri = Uri.parse(GlobalValue.BASE_URL + GlobalValue.APPLICATIONS_URL);
      await apps.ready;
      try {
        final response = await http.get(uri, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
        if (response.statusCode == 200) {
          apps.setItem('applications', response.body);
          print('applications sync is success');
          return true;
        } else {
          print('ERROR CODE: ' +
              response.statusCode.toString() +
              '\n ERROR MESSAGE: ' +
              response.body);
          return false;
        }
      } on FormatException catch (_) {
        print('connection problem');
        return false;
      } on SocketException catch (_) {
        print('Socket error');
        return false;
      }
    }

    loginUser(String username, password) async {
      await login.ready;
      Uri loginUri = Uri.parse(GlobalValue.BASE_URL + GlobalValue.LOGIN_URL);
      try {
        var response = await http
            .post(loginUri, body: {"username": username, "password": password});

        print(response.body);
        try {
          if (response.statusCode == 200) {
            var value = response.body;
            login.setItem('login', value);
            print('Login Data Stored to Local Storage.');
            bool homeReady = await setUppApplications();
            if (homeReady) {
              progress.hide();
              Toast.ShowSnackBar(context, 'Login success');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              Toast.ShowSnackBar(
                  context, 'Check your connection and try again');
            }
          } else {
            setState(() {
              username_error = LoginError.fromJson(jsonDecode(response.body))
                  .errorPayload!
                  .errors!
                  .username;

              password_error = LoginError.fromJson(jsonDecode(response.body))
                  .errorPayload!
                  .errors!
                  .password;

              progress.hide();
              print('Has errors.');
            });
            Toast.ShowSnackBar(context, 'Login failed');
          }
        } on FormatException catch (_) {
          print('No Active Network');
          Toast.ShowSnackBar(context, 'Check your connection and try again');
          progress.hide();
        }
      } on SocketException catch (_) {
        print('Socket exception');
        Toast.ShowSnackBar(context, 'Error while trying to login.');
        progress.hide();
      }
    }

    return MaterialApp(
        title: 'myapp',
        home: Form(
          key: loginFormState,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CrackerIt company',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                    Text(
                      'Login to Your App',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 44.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: username,
                      validator: (value) {
                        if (username_error != null) {
                          return username_error;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Username or email',
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextFormField(
                      obscureText: hidePassword,
                      controller: password,
                      validator: (value) {
                        if (password_error != null) {
                          return password_error;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text(
                      'Don\'t  remember your password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 88.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RawMaterialButton(
                        fillColor: Color(0xFF0069FE),
                        elevation: 8.0,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          progress.show();

                          await loginUser(username.text, password.text);
                          if (loginFormState.currentState!.validate()) {
                            progress.hide();
                          }

                          Future.delayed(Duration(seconds: 3), () {});
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
