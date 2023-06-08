import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:flutter/material.dart';

class FromBuyer extends StatefulWidget {
  const FromBuyer({Key? key}) : super(key: key);

  @override
  _FromBuyerState createState() => _FromBuyerState();
}

class _FromBuyerState extends State<FromBuyer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 10; i++) InboxCard(),
        ],
      ),
    );
  }
}
