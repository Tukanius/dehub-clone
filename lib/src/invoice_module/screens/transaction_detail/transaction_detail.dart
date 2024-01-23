import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoiceTransactionDetailArguments {
  String id;
  InvoiceTransactionDetailArguments({
    required this.id,
  });
}

class InvoiceTransactionDetail extends StatefulWidget {
  static const routeName = '/InvoiceTransactionDetail';
  final String id;
  const InvoiceTransactionDetail({
    super.key,
    required this.id,
  });

  @override
  State<InvoiceTransactionDetail> createState() =>
      _InvoiceTransactionDetailState();
}

class _InvoiceTransactionDetailState extends State<InvoiceTransactionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: invoiceColor),
        title: const Text(
          'Гүйлгээний мэдээлэл',
          style: TextStyle(
            color: invoiceColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Гүйлгээний лавлах дугаар',
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'INV-23897',
                  style: TextStyle(
                    color: invoiceColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Гүйлгээний мэдээлэл',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Гүйлгээний огноо",
              secondText: "Огноо, цаг",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Төлбөрийн дүн",
              secondText: "Төлсөн дүн",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Гүйлгээний утга",
              secondText: "Гүйлгээний утга",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Төлбөрийн хэрэгсэл",
              secondText: "DeHUB",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Харилцагчийн мэдээлэл',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Худалдан авагч",
              secondText: "Ref#, BuyerName",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Партнер нэр",
              secondText: "Ref#, PartnerName",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Төлбөр хийсэн",
              secondText: "DeHUB",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Хүлээн авсан данс',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Дансны дугаар",
              secondText: "Дансны дугаар",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Дансны нэр",
              secondText: "Дансны нэр",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Банкны нэр",
              secondText: "Банкны нэр",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Шилжүүлэгч данс',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Дансны дугаар",
              secondText: "Дансны дугаар",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Дансны нэр",
              secondText: "Дансны нэр",
              secondTextColor: invoiceColor,
            ),
            const FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Банкны нэр",
              secondText: "Банкны нэр",
              secondTextColor: invoiceColor,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
