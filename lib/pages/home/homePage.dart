import 'package:acrib/pages/home/SimpleCard.dart';
import 'package:acrib/pages/home/TransactionsList.dart';
import 'package:acrib/pages/home/todoLists.dart';
import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.99),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Good Morning,\nKinyua",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const XMargin(10),
            CardsView(),
            const XMargin(10),
            const YMargin(10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TodoListHeader(),
            ),
            const YMargin(10),
            SizedBox(height: 180, child: TodoList()),
            const YMargin(10),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TransactionsHeader(),
            ),
            SizedBox(height: 500, child: TransactionList()),
          ],
        ),
      ),
    );
  }
}

class CardsView extends StatelessWidget {
  const CardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          const XMargin(8),
          SimpleCard(cardColor: Colors.tealAccent[400]),
          SimpleCard(cardColor: Colors.lightBlue[400]),
        ],
      ),
    );
  }
}
