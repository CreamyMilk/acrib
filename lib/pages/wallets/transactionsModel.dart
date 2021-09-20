import 'dart:convert';

import 'package:acrib/constants.dart';
import 'package:acrib/widgets/snackBars.dart';
import 'package:hive/hive.dart';

class Transaction {
  String? transID;
  String? transCode;
  String? sender;
  String? receiver;
  int? amount;
  int? charge;
  int? type;
  String? timeoftrans;
  Map<String, dynamic> __origJson = {};

  Transaction({
    this.transID,
    this.transCode,
    this.sender,
    this.receiver,
    this.amount,
    this.charge,
    this.type,
    this.timeoftrans,
  });
  Transaction.fromJson(Map<String, dynamic> json) {
    __origJson = json;
    transID = json["transID"]?.toString();
    transCode = json["transCode"]?.toString();
    sender = json["sender"]?.toString();
    receiver = json["receiver"]?.toString();
    amount = json["amount"]?.toInt();
    charge = json["charge"]?.toInt();
    type = json["type"]?.toInt();
    timeoftrans = json["timeoftrans"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["transID"] = transID;
    data["transCode"] = transCode;
    data["sender"] = sender;
    data["receiver"] = receiver;
    data["amount"] = amount;
    data["charge"] = charge;
    data["type"] = type;
    data["timeoftrans"] = timeoftrans;
    return data;
  }

  Map<String, dynamic> origJson() => __origJson;
}

class TransResponse {
  int? status;
  String? message;
  List<Transaction?>? transactions;
  Map<String, dynamic> __origJson = {};

  TransResponse({
    this.status,
    this.message,
    this.transactions,
  });
  TransResponse.fromJson(Map<String, dynamic> json) {
    __origJson = json;
    status = json["status"]?.toInt();
    message = json["message"]?.toString();
    if (json["transactions"] != null) {
      final v = json["transactions"];
      final arr0 = <Transaction>[];
      v.forEach((v) {
        arr0.add(Transaction.fromJson(v));
      });
      transactions = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["message"] = message;
    if (transactions != null) {
      final v = transactions;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["transactions"] = arr0;
    }
    return data;
  }

  Map<String, dynamic> origJson() => __origJson;

  bool persistTrans() {
    try {
      Box usersBox = Hive.box(Constants.UserBoxName);
      if (transactions != null) {
        usersBox.put(Constants.TransactionsListStore, jsonEncode(origJson()));
      }
      return true;
    } catch (err) {
      showSnack(err);
      print(err);
      return false;
    }
  }
}
