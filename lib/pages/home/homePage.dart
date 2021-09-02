import 'package:acrib/pages/home/SimpleCard.dart';
import 'package:acrib/pages/home/TransactionsList.dart';
import 'package:acrib/pages/home/todoLists.dart';
import 'package:acrib/pages/wallets/walletsPage.dart';
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
            CardsView(),
            const YMargin(10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TodoListHeader(),
            ),
            const YMargin(10),
            Center(child: WalletActions()),
            // const YMargin(10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: TodoListHeader(),
            // ),
            // SizedBox(height: 180, child: TodoList()),
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

class CardsView extends StatefulWidget {
  const CardsView({Key? key}) : super(key: key);

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  late PageController _simpleCardsController;

  @override
  void initState() {
    _simpleCardsController = PageController(
      viewportFraction: .8,
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> simpleCardsArray = [
      SimpleCard(
        cardColor: Colors.lightBlue[400],
        cardTitle: "Rent Due",
        cardActionText: "View Receipts",
        cardAmount: "75,340",
      ),
      SimpleCard(
        cardColor: Colors.tealAccent[400],
        cardTitle: "Wallet",
        cardActionText: "View Transactions",
        cardAmount: "5,773",
      ),
    ];
    return SizedBox(
      height: 180,
      child: PageView.builder(
        allowImplicitScrolling: true,
        onPageChanged: (int pageNumber) {
          print("The current page number is $pageNumber");
        },
        controller: _simpleCardsController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: simpleCardsArray.length,
        itemBuilder: (ctx, idx) {
          return GestureDetector(
            onDoubleTap: () {
              _simpleCardsController.animateToPage(
                idx,
                duration: Duration(seconds: 1),
                curve: Curves.decelerate,
              );
              print("You double tapped the card so autonavigation $idx");
            },
            child: simpleCardsArray[idx],
          );
        },
      ),
    );
  }
}
