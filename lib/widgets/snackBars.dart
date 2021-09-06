import 'package:acrib/main.dart';
import 'package:flutter/material.dart';

void showSnack(dynamic mess) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text("Error Sending the deposit request because $mess"),
      action: SnackBarAction(
        label: "Close",
        onPressed: () {},
      ),
    ),
  );
}
