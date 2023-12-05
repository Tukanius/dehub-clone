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
    Key? key,
    required this.id,
  }) : super(key: key);

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
        elevation: 0,
        iconTheme: IconThemeData(color: invoiceColor),
        title: Text(
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
                child: Text(
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
                child: Text(
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
              child: Text(
                'Гүйлгээний мэдээлэл',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Гүйлгээний огноо",
              secondText: "Огноо, цаг",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Төлбөрийн дүн",
              secondText: "Төлсөн дүн",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Гүйлгээний утга",
              secondText: "Гүйлгээний утга",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Төлбөрийн хэрэгсэл",
              secondText: "DeHUB",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Харилцагчийн мэдээлэл',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Худалдан авагч",
              secondText: "Ref#, BuyerName",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Партнер нэр",
              secondText: "Ref#, PartnerName",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Төлбөр хийсэн",
              secondText: "DeHUB",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Хүлээн авсан данс',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Дансны дугаар",
              secondText: "Дансны дугаар",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Дансны нэр",
              secondText: "Дансны нэр",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Банкны нэр",
              secondText: "Банкны нэр",
              secondTextColor: invoiceColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Шилжүүлэгч данс',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Дансны дугаар",
              secondText: "Дансны дугаар",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Дансны нэр",
              secondText: "Дансны нэр",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              color: white,
              labelText: "Банкны нэр",
              secondText: "Банкны нэр",
              secondTextColor: invoiceColor,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
