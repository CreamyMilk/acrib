import 'package:acrib/main.dart';
import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';

showErrorDialog({required String error}) => showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Container(
            width: screenWidth(context, percent: 0.6),
            height: screenHeight(context, percent: 0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Error",
                  ),
                  const YMargin(10),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      error,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  const YMargin(20),
                ],
              ),
            ),
          ),
        );
      },
    );
