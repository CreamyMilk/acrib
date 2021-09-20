import 'dart:convert';

import 'package:acrib/constants.dart';
import 'package:acrib/pages/wallets/transactionsModel.dart';
import 'package:acrib/widgets/snackBars.dart';
import 'package:http/http.dart' as http;

Future getLatestTransactions() async {
  try {
    final response = await http.post(
      Uri.parse("${Constants.API_BASE}/api/v1/wallet/transactions"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode({
        "walletid": Constants.getWalletID(),
      }),
    );
    Map<String, dynamic> myjson = json.decode(response.body);
    if (myjson["status"] != null && myjson["status"] == 0) {
      TransResponse resp = TransResponse.fromJson(myjson);
      if (resp.persistTrans()) {
        print('Cached Transactions Succesfully');
      }
    }
  } catch (err) {
    showSnack(err);
  }
}
