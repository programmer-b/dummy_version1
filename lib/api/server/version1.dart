// ignore_for_file: avoid_print, unnecessary_new, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dummy_12/model/applications.dart';

import 'package:http/http.dart' as http;

import 'package:localstorage/localstorage.dart';
import 'package:dummy_12/model/utils.dart';
import 'package:dummy_12/model/auth/login/login_success.dart';

// ignore: unnecessary_new
final LocalStorage apps = new LocalStorage('apps');
final LocalStorage login = new LocalStorage('loginData');

class GET {
  static Future<Applications> fetchApps() async {
    Uri uri = Uri.parse(GlobalValue.BASE_URL + GlobalValue.APPLICATIONS_URL);

    await apps.ready;
    await login.ready;

    String? token = LoginSuccess.fromJson(jsonDecode(login.getItem('login')))
        .dataPayload!
        .data!
        .token;

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var res = Applications.fromJson(jsonDecode(response.body));
        var value = response.body;
        print('STATUS_CODE IS 200');

        apps.setItem('applications', value);

        print('successfully synced data from the local storage.');

        init_0();
        return res;
      } else {
        // ignore: avoid_print
        print('expired token. MUST_RENEW.OK.');
        print('STATUS CODE IS ' +
            response.statusCode.toString() +
            ' THE TOKEN IS: ' +
            token!);
        print('ReSPONSE: ' + response.body);

        GlobalValue.tokenExpired = true;
        return response_1;
      }
    } on SocketException catch (_) {
      print('SOCKET EXCEPTION');
      init_0();
      return response_1;
    } on FormatException catch (_) {
      print('FORMAT EXCEPTION');
      init_0();
      return response_1;
    } on http.ClientException catch (_) {
      print('CLIENT EXCEPTION');
      init_0();
      return response_1;
    }
  }

  static init_0() {
    GlobalValue.tokenExpired = false;
    
    if (!GlobalValue.isStarted) {
      GlobalValue.initTitle =
          Applications.fromJson(jsonDecode(apps.getItem('applications')))
              .dataPayload
              .data[0]
              .name;
      GlobalValue.isStarted = true;
    } else {
      GlobalValue.isStarted = true;
    }
  }

  static var response_1 =
      Applications.fromJson(jsonDecode(apps.getItem('applications')));
}
