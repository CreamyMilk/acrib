import 'package:acrib/constants.dart';
import 'package:acrib/pages/wallets/DepositFuture.dart';
import 'package:acrib/utils/sizedMargins.dart';
import 'package:acrib/utils/typeExtensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showPaymentSheet(BuildContext ctx) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
    ),
    context: ctx,
    builder: (BuildContext context) {
      return PaymentBottomSheet();
    },
  );
}

String? validateAmount(String value) {
  if (!(value.length < 7) && value.isNotEmpty) {
    if (value[0] != "0") {
      return "A Maximum limit of Ksh 1,000,000 is allowed.";
    }
    if (int.tryParse(value) == null) {
      return "The Supplied Amount is invalid";
    }
  }
  return null;
}

String? validatePhone(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    if (value[0] != "0") {
      return "Mobile should be in the format 07xx or 01xx";
    }
    return null;
  }
  return null;
}

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final TextEditingController _phoneficontroller = TextEditingController();
  final TextEditingController _amountficontroller = TextEditingController();
  late String mobile;
  late String depositAmount;
  late String walletName;

  @override
  void initState() {
    mobile = Constants.getPhone();
    walletName = Constants.getWalletID();
    depositAmount = "100";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sheetTitle = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.add, size: 17),
        Text(
          "Wallet Deposit",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        SizedBox()
      ],
    );
    Row amountColumnText = Row(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ksh :",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                depositAmount.addCommas,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Phone",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                mobile,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
    TextField amountTextFieldArea = TextField(
      autofocus: true,
      onChanged: (value) {
        print(value);
        setState(() {
          depositAmount = value;
        });
      },
      controller: _amountficontroller,
      decoration: InputDecoration(
        isDense: false,
        border: OutlineInputBorder(gapPadding: 0.9),
        labelText: 'Amount',
        hintText: 'In shillings',
        errorText: validateAmount(_amountficontroller.text),
        prefixText: "",
      ),
      keyboardType: TextInputType.number,
    );
    Text lowCashText = Text(
      "Running low on Cash ?",
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 13),
    );
    TextFormField phoneTextFieldArea = TextFormField(
      autofocus: true,
      onChanged: (value) {
        print(value);
        setState(() {
          mobile = value;
        });
      },
      controller: _phoneficontroller,
      maxLength: 10,
      decoration: InputDecoration(
        isDense: false,
        border: OutlineInputBorder(gapPadding: 0.2),
        hintText: 'As someone else to pay ',
        errorText: validatePhone(_phoneficontroller.text),
        prefixText: "",
      ),
      keyboardType: TextInputType.number,
    );
    Container sendButton = Container(
      child: MaterialButton(
        elevation: 0,
        height: 60,
        minWidth: MediaQuery.of(context).size.width * .95,
        onPressed: () async {
          sendDepositRequest(
            DepositStruct(
              amount: int.parse(depositAmount),
              walletID: walletName,
              phoneNumber: mobile,
            ),
          );
          Navigator.of(context).pop();
          print("send");
        },
        color: Colors.greenAccent[400],
        child: Text(
          "Deposit ${depositAmount.addCommas}",
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        autofocus: true,
      ),
    );
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          decoration: BoxDecoration(),
          child: Column(
            children: [
              sheetTitle,
              Divider(),
              const YMargin(5),
              amountColumnText,
              const YMargin(20),
              amountTextFieldArea,
              const YMargin(20),
              Align(
                alignment: Alignment.centerLeft,
                child: lowCashText,
              ),
              phoneTextFieldArea,
              const YMargin(20),
              Align(
                alignment: Alignment.bottomCenter,
                child: sendButton,
              ),
              const YMargin(20),
            ],
          ),
        ),
      ),
    );
  }
}
