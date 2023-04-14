import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoiceEmpty extends StatefulWidget {
  const InvoiceEmpty({super.key});

  @override
  State<InvoiceEmpty> createState() => _InvoiceEmptyState();
}

class _InvoiceEmptyState extends State<InvoiceEmpty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 150,
          width: 150,
          child: Image.asset("images/invoice_empty.png"),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Нэхэмжлэх байхгүй',
          style: TextStyle(
            color: grey3,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'Танд АПП-д бүртгэж баталгаажуулсан нэхэмжлэх байхгүй байна. “+” товчийг сонгож шинэ нэхэмжлэх бүртгээрэй.',
            style: TextStyle(
              fontSize: 14,
              color: grey3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Танд амжилт хүсье',
          style: TextStyle(
            fontSize: 14,
            color: grey3,
          ),
        )
      ],
    );
  }
}
