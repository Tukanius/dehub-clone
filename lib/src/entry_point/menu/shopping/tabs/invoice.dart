import 'package:flutter/material.dart';
import 'package:dehub/components/sales_page_cards/invoice_card.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InvoiceCard(),
        ],
      ),
    );
  }
}
