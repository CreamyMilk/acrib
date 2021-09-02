import 'package:acrib/pages/wallets/addMoneyBottomSheet.dart';
import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';

class WalletsPage extends StatelessWidget {
  const WalletsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Hello\nJohn Doe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            Center(child: WalletActions()),
          ],
        ),
      ),
    );
  }
}

class WalletActions extends StatelessWidget {
  const WalletActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleWalletAction(
              actionIcon: Icons.save_alt_sharp,
              actionName: "Add\n Money",
              pressedHook: () => {showPaymentSheet(context)},
            ),
            SingleWalletAction(
                actionIcon: Icons.bolt, actionName: "Buy\nTokens"),
            SingleWalletAction(
                actionIcon: Icons.dock_sharp, actionName: "Pay\nWater Bill"),
            SingleWalletAction(
                actionIcon: Icons.airplane_ticket_outlined,
                actionName: "Pay\nFor Service")
          ],
        ),
      ),
    );
  }
}

class SingleWalletAction extends StatelessWidget {
  const SingleWalletAction(
      {Key? key,
      required this.actionIcon,
      required this.actionName,
      this.pressedHook})
      : super(key: key);
  final IconData? actionIcon;
  final String actionName;
  final Function? pressedHook;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pressedHook!();
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green[50],
              radius: 22,
              child: Icon(
                actionIcon,
                size: 20,
                color: Colors.greenAccent[400],
              ),
            ),
            const YMargin(10),
            Text(actionName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      ),
    );
  }
}
