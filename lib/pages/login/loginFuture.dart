import 'dart:convert';

import 'package:acrib/constants.dart';
import 'package:acrib/main.dart';
import 'package:acrib/pages/login/models.dart';
import 'package:acrib/widgets/snackBars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginStruct {
  final String phoneNumber;
  LoginStruct({required this.phoneNumber});
}

Future sendLoginRequest(LoginStruct loginCreds) async {
  try {
    final response = await http.post(
      Uri.parse("${Constants.API_BASE}/api/v1/tenants/login"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode({
        "phone": loginCreds.phoneNumber,
      }),
    );
    //Clear Cache
    bool cleard = await Constants.logout();
    if (cleard) {
      print("Cleared Cached Details");
    } else {
      print("Error clearing cache");
    }
    Map<String, dynamic> myjson = json.decode(response.body);
    if (myjson["status"] != null && myjson["status"] == 0) {
      LoginResponse resp = LoginResponse.fromJson(myjson);
      if (resp.persist()) {
        Navigator.of(navigatorKey.currentContext!).pushNamed("/");
      }
    }
  } catch (err) {
    showSnack(err);
  }
}
