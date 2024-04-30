import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceTransactionDetailArguments {
  Invoice data;
  InvoiceTransactionDetailArguments({
    required this.data,
  });
}

class InvoiceTransactionDetail extends StatefulWidget {
  static const routeName = '/InvoiceTransactionDetail';
  final Invoice data;
  const InvoiceTransactionDetail({
    super.key,
    required this.data,
  });

  @override
  State<InvoiceTransactionDetail> createState() =>
      _InvoiceTransactionDetailState();
}

class _InvoiceTransactionDetailState extends State<InvoiceTransactionDetail> {
  General general = General();

  paymentMethod() {
    final res = general.paymentMethod!
        .firstWhere((element) => element.code == widget.data.paymentMethod)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;
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
                child: Text(
                  '${widget.data.description}',
                  style: const TextStyle(
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
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Гүйлгээний огноо",
              secondText:
                  DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!),
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Төлбөрийн дүн",
              secondText:
                  "${Utils().formatCurrency(widget.data.trxAmount.toString())}₮",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Гүйлгээний утга",
              secondText: "${widget.data.description}",
              secondTextColor: invoiceColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: "Төлбөрийн хэрэгсэл",
              secondText: "${paymentMethod()}",
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
