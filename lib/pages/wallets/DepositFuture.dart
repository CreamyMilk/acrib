import 'dart:convert';

import 'package:acrib/constants.dart';
import 'package:acrib/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepositStruct {
  final int amount;
  final String walletID;
  final String phoneNumber;
  DepositStruct(
      {required this.amount,
      required this.walletID,
      required this.phoneNumber});
}

Future sendDepositRequest(DepositStruct dep) async {
  try {
    final response = await http.post(
      Uri.parse("${Constants.API_BASE}/api/v1/wallet/deposit"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {
          'phone': dep.phoneNumber,
          'walletid': dep.walletID,
          'amount': dep.amount,
        },
      ),
    );
    dynamic myjson = json.decode(response.body);
    return myjson;
  } catch (err) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text("Error Sending the deposit request because $err"),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            Navigator.of(navigatorKey.currentContext!).pop();
          },
        ),
      ),
    );
  }
}
