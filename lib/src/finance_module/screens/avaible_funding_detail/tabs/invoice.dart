import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceTab extends StatefulWidget {
  const InvoiceTab({super.key});

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Нэхэмжлэх статус',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Invoice_ref',
                    style: TextStyle(color: source.currentColor),
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
                    'Илгээсэн ажилтан',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Supplier_UserName',
                    style: TextStyle(color: source.currentColor),
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
                    'Илгээсэн огноо, цаг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Invoice_Sent_Datetime',
                    style: TextStyle(color: black),
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
                    'Баталсан ажилтан',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Buyer_UserName',
                    style: TextStyle(color: source.currentColor),
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
                    'Баталсан огноо, цаг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Approved_DateTime',
                    style: TextStyle(color: black),
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
                    'Баталсан дүн',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '00.00 ₮',
                    style: TextStyle(color: source.currentColor),
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
                    'Төлсөн дүн',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Нийт төлсөн дүн',
                    style: TextStyle(color: source.currentColor),
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
                    'Үлдэгдэл төлбөр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '10,200,200.00 ₮',
                    style: TextStyle(
                      color: source.currentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
                    'Нэхэмжлэх төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Color(0xffD3E9FF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Баталсан',
                      style: TextStyle(
                        color: Color(0xff2290FF),
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
                    'Нэхэмжлэх төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Color(0xffD9E1F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Хуваан төлсөн',
                      style: TextStyle(
                        color: Color(0xff4169E1),
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
                    'Нэхэмжлэх төлөв',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Normal',
                      style: TextStyle(color: green),
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
                    'INV_NET_30',
                    style: TextStyle(color: source.currentColor, fontSize: 18),
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
                    'Invoice_Due_Date',
                    style: TextStyle(color: source.currentColor, fontSize: 18),
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
                    style: TextStyle(color: source.currentColor, fontSize: 20),
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
                            color: source.currentColor,
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
                    style: TextStyle(color: source.currentColor, fontSize: 18),
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
                    style: TextStyle(color: source.currentColor),
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
                    style: TextStyle(color: source.currentColor),
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
                    style: TextStyle(color: source.currentColor),
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
                    style: TextStyle(color: source.currentColor),
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
}
