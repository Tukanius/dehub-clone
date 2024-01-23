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
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset("images/invoice_empty.png"),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Нэхэмжлэх байхгүй',
          style: TextStyle(
            color: grey3,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: const Text(
            'Танд АПП-д бүртгэж баталгаажуулсан нэхэмжлэх байхгүй байна. “+” товчийг сонгож шинэ нэхэмжлэх бүртгээрэй.',
            style: TextStyle(
              fontSize: 14,
              color: grey3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
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
