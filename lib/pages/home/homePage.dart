import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text("Hello\nGoodDay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const XMargin(10),
            CardsView(),
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
          SimpleCard(cardColor: Colors.lightBlue[400]),
          SimpleCard(cardColor: Colors.greenAccent[400])
        ],
      ),
    );
  }
}

class SimpleCard extends StatelessWidget {
  final Color? cardColor;
  const SimpleCard({Key? key, @required this.cardColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> dues = <String>['Jan.2020', 'Feb.2020', 'March.2020'];
    String selectedItem = dues[0];
    Align cardDropDownTitle = Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 30,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: const TextStyle(color: Colors.white, fontSize: 15),
            selectedItemBuilder: (BuildContext context) {
              return dues.map<Widget>((String due) {
                return Text(due);
              }).toList();
            },
            items: dues.map((String item) {
              return DropdownMenuItem<String>(
                child: Text(
                  "Lost $item",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: item,
              );
            }).toList(),
            onChanged: (newValue) {
              print(newValue);
            },
            value: selectedItem,
            icon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    RichText amountDueText = RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "\ksh.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          TextSpan(text: "50,000", style: TextStyle(fontSize: 25)),
        ],
      ),
    );
    Text actionText = Text(
      "View Receipts",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        decoration: TextDecoration.underline,
      ),
    );
    return Container(
      margin:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
      width: 300,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          const YMargin(10),
          cardDropDownTitle,
          const YMargin(5),
          Text(
            "Rent Due",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const YMargin(5),
          amountDueText,
          Spacer(),
          actionText,
          const YMargin(10)
        ],
      ),
    );
  }
}
