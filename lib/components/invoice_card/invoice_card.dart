import 'package:flutter/material.dart';

class InvoiceCard extends StatefulWidget {
  const InvoiceCard({super.key});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '2021-12-01',
            style: TextStyle(
              color: Color(0xff636E72),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
