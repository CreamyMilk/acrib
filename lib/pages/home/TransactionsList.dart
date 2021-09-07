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

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ListView.separated(
        separatorBuilder: (_, __) {
          return Container();
        },
        itemCount: 5,
        itemBuilder: (ctx, idx) {
          return ExpansionTile(
            children: [
              Row(children: [
                MaterialButton(onPressed: () {}, child: Text("Receipt")),
              ]),
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
              "January",
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text(
              "Ksh.${1232 * idx}",
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              "$now",
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
            ),
          );
        });
  }
}
