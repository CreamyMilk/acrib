import 'package:acrib/constants.dart';
import 'package:acrib/pages/wallets/getTransactionsFuture.dart';
import 'package:acrib/pages/wallets/transactionsModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Transactions",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          Text(
            "See All",
            style: TextStyle(fontSize: 11, color: Colors.greenAccent[400]),
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    getLatestTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Constants.UserBoxName).listenable(),
      builder: (BuildContext ctx, Box<dynamic> box, child) {
        String? jsonStr = box.get(Constants.TransactionsListStore,
            defaultValue: '{"transactions": []}');
        TransResponse resp = TransResponse.fromJson(jsonDecode(jsonStr!));
        List<Transaction?>? transactionz = resp.transactions;
        return ListView.separated(
          separatorBuilder: (_, __) {
            return Container();
          },
          itemCount: transactionz!.length,
          itemBuilder: (BuildContext ctx, int idx) {
            Transaction? t = transactionz[idx];
            DateTime tot = DateTime.now();
            if (t!.timeoftrans != null) {
              tot = DateTime.parse(t.timeoftrans as String);
            }
            String transactionTime = tot.year.toString();
            return ExpansionTile(
              children: [
                Row(children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Receipt"),
                  ),
                ])
              ],
              leading: CircleAvatar(
                backgroundColor: Colors.green[50],
                child: Icon(
                  Icons.water_rounded,
                  size: 17,
                  color: Colors.greenAccent[400],
                ),
              ),
              title: Text(
                "${t.transID}",
                style: TextStyle(fontSize: 15),
              ),
              trailing: Text("Ksh.${t.amount}", style: TextStyle(fontSize: 14)),
              subtitle: Text(
                "$transactionTime",
                style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
              ),
            );
          },
        );
      },
    );
  }
}
