import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceTab extends StatefulWidget {
  final Finance data;
  const InvoiceTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                'Нэхэмжлэхийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Нэхэмжлэх статус',
              secondText: '${widget.data.invRefCode}',
              secondTextColor: financingColor,
              color: white,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Илгээсэн ажилтан',
              secondText: '${widget.data.invSenderUser?.firstName}',
              secondTextColor: financingColor,
              color: white,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Илгээсэн огноо, цаг',
              secondText:
                  '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!)}',
              color: white,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Баталсан ажилтан',
              secondText: '${widget.data.invConfirmedUser?.firstName}',
              secondTextColor: financingColor,
              color: white,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Баталсан огноо, цаг',
              secondText:
                  '${DateFormat('yyyy-MM-dd HH:mm').format(widget.data.invConfirmedDate!)}',
              color: white,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Баталсан дүн',
              secondText:
                  '${Utils().formatCurrency(widget.data.invConfirmedAmount.toString())}',
              color: white,
              secondTextColor: financingColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Төлсөн дүн',
              secondText:
                  '${Utils().formatCurrency(widget.data.invPaidAmount.toString()) + currency()}',
              color: white,
              secondTextColor: financingColor,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: 'Үлдэгдэл төлбөр',
              secondText:
                  '${Utils().formatCurrency(widget.data.invAmountToPay.toString()) + currency()}',
              color: white,
              secondTextColor: financingColor,
              secondTextFontWeight: FontWeight.w500,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Нэхэмжлэх төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: invoiceStatusColor(true),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${invoiceStatus().name}',
                      style: TextStyle(
                        color: invoiceStatusColor(false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Төлбөрийн төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: invoicePaymentStatusColor(true),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${invoicePaymentStatus()}',
                      style: TextStyle(
                        color: invoicePaymentStatusColor(false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Хугацаа хэтрэлт',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                                  invoiceOverdueStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${invoiceOverdueStatus().name}',
                      style: TextStyle(
                        color: Color(int.parse(
                                invoiceOverdueStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Төлбөрийн нөхцөл',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '${widget.data.invPaymentTermConfigType}',
                    style: TextStyle(color: financingColor, fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Нэхэмжлэх төлөх огноо',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '${DateFormat("yyyy-MM-dd").format(widget.data.invPaymentDate!)}',
                    style: TextStyle(color: financingColor, fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Нэхэмжлэлийн баримт',
                style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: white,
              child: Row(
                children: [
                  Icon(Icons.downloading_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'INV_32093282.PDF',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff151357),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Худалдан авагч тал',
                style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ХА Захиалга №',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'PO#3232-1',
                    style: TextStyle(color: financingColor, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Партнер',
                    style: TextStyle(color: dark),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Partner_Ref#, ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: financingColor,
                          ),
                        ),
                        TextSpan(
                          text: 'PartnerName',
                          style: TextStyle(color: grey2, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ТТД',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Tax_Registration_ID',
                    style: TextStyle(color: financingColor, fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дансны дугаар',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Account_Number',
                    style: TextStyle(color: financingColor),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дансны нэр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Account_Name',
                    style: TextStyle(color: financingColor),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Банкны нэр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Банкны нэр',
                    style: TextStyle(color: dark),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Санхүү ажилтан нэр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Finance_user',
                    style: TextStyle(color: financingColor),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Санхүү ажилтан утас',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Phone_Number',
                    style: TextStyle(color: financingColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }

  invoicePaymentStatus() {
    final res = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == widget.data.invPaymentStatus)
        .name;
    return res;
  }

  invoiceOverdueStatus() {
    final res = general.invoiceOverdueStatus!
        .firstWhere((element) => element.code == widget.data.invOverdueStatus);
    return res;
  }

  invoicePaymentStatusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.invPaymentStatus) {
        case "DRAFT":
          return grey;
        case "PENDING":
          return yellow;
        case "DIVIDED":
          return blue;
        case "CLOSED":
          return green;
        default:
      }
    } else {
      switch (widget.data.invPaymentStatus) {
        case "DRAFT":
          return grey.withOpacity(0.2);
        case "PENDING":
          return yellow.withOpacity(0.2);
        case "DIVIDED":
          return blue.withOpacity(0.2);
        case "CLOSED":
          return green.withOpacity(0.2);
        default:
      }
    }
  }

  invoiceStatusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.invStatus) {
        case "DRAFT":
          return grey;
        case "SENT":
          return Colors.indigo;
        case "CONFIRMED":
          return lightBlue;
        case "REJECTED":
          return red;
        case "RETURNED":
          return pink;
        case "CANCELED":
          return pink;
        case "CLOSED":
          return green;
        default:
      }
    } else {
      switch (widget.data.invStatus) {
        case "DRAFT":
          return grey.withOpacity(0.2);
        case "SENT":
          return Colors.indigo.withOpacity(0.2);
        case "CONFIRMED":
          return lightBlue.withOpacity(0.2);
        case "REJECTED":
          return red.withOpacity(0.2);
        case "RETURNED":
          return pink.withOpacity(0.2);
        case "CANCELED":
          return pink.withOpacity(0.2);
        case "CLOSED":
          return green.withOpacity(0.2);
        default:
      }
    }
  }

  invoiceStatus() {
    final res = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invStatus);
    return res;
  }
}
