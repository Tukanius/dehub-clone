import 'package:dehub/components/transaction_information_card/transaction_information_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TransactionInformationCard(
            color: red,
          ),
          TransactionInformationCard(
            color: green,
          ),
        ],
      ),
    );
  }
}
