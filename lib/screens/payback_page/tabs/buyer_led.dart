import 'package:dehub/components/payback_card/payback_card.dart';
import 'package:dehub/screens/payback_detail/payback_detail.dart';
import 'package:flutter/material.dart';

class BuyerLed extends StatefulWidget {
  const BuyerLed({super.key});

  @override
  State<BuyerLed> createState() => _BuyerLedState();
}

class _BuyerLedState extends State<BuyerLed> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          PaybackCard(
            onClick: () {
              Navigator.of(context).pushNamed(PaybackDetail.routeName);
            },
          ),
        ],
      ),
    );
  }
}
