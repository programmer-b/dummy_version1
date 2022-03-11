// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, prefer_const_constructors, unnecessary_new

// @dancan  :: Here am declaring values that are needed in other classes.

import 'package:dummy_12/model/auth/login/login_success.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final LocalStorage login = LocalStorage('loginData');

class GlobalValue {
  static final String BASE_URL = 'http://api.crackit.tk/';
  static final String LOGIN_URL = 'v1/auth/login';
  static final APPLICATIONS_URL = 'v1/config/settings/applications';

  static String initTitle = "";

  static bool isStarted = false;
  static bool tokenExpired = false;

  static final Color drawerItemColor = Colors.blueGrey;
  static final Color? drawerItemSelectedColor = Colors.blue[700];
  static final Color? drawerSelectedTileColor = Colors.blue[100];
}

class Toast {
  static ShowSnackBar(BuildContext context, String message) {
    showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: message,
        ));
  }
}
