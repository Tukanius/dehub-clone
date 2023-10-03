import 'package:dehub/components/sales_page_cards/payment_card.dart';
import 'package:flutter/material.dart';

class ShoppingPayment extends StatefulWidget {
  const ShoppingPayment({super.key});

  @override
  State<ShoppingPayment> createState() => _ShoppingPaymentState();
}

class _ShoppingPaymentState extends State<ShoppingPayment> {
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
