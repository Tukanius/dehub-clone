import 'package:dehub/components/sales_page_cards/payment_card.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PaymentCard(),
        ],
      ),
    );
  }
}
