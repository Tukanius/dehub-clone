import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
// import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/screens/invoice/payment_page/payment_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class BasicInformationTab extends StatefulWidget {
  final String id;
  BasicInformationTab({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab>
    with AfterLayoutMixin {
  Invoice invoice = Invoice();
  General general = General();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).general;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: isLoading == true
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэхэмжлэх',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нэхэмжлэх №',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${invoice.refCode}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Нэхэмжлэх статус',
                          ),
                        ),
                        Text(
                          invoiceStatus(),
                          style: TextStyle(
                            color: invoiceStatusColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Төлбөрийн төлөв',
                          ),
                        ),
                        Text(
                          invoicePaymentStatus(),
                          style: TextStyle(
                            color: textColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Нийт дүн',
                          ),
                        ),
                        Text(
                          '${Utils().formatCurrency(invoice.itemsTotal.toString())}',
                          // '',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Төлсөн дүн',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          "${Utils().formatCurrency(invoice.paidAmount.toString())}",
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Төлбөрийн үлдэгдэл',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          // '${Utils().formatCurrency(invoice.amountToPay.toString())}',
                          '',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Төлөх огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          // invoice.getPaymentDate(),
                          '',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Хугацаа хэтрэлт',
                          ),
                        ),
                        Text(
                          '${overdueStatus()}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Баталсан огноо',
                          ),
                        ),
                        Text(
                          '${invoice.getsentDate()}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Худалдан авагч тал',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Татар төлөгч дугаар',
                          ),
                        ),
                        Text(
                          'Дугаар',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Партнерийн нэр,',
                              ),
                            ),
                            Text(
                              'Партнер код',
                              style: TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: grey3,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Худалдан авагч бизнес,',
                              ),
                            ),
                            Text(
                              'Партнер код',
                              style: TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: grey3,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Төлбөрийн нөхцөл',
                          ),
                        ),
                        Text(
                          'INV_NET_X',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Бизнесийн хаяг',
                          ),
                        ),
                        Text(
                          'Бизнесийн хаяг',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Санхүүгийн ажилтан',
                          ),
                        ),
                        Text(
                          'Санхүүгийн ажилтан',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Дансны мэдээлэл',
                          ),
                        ),
                        Text(
                          'Дансны дугаар, нэр',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Хүлээн авсан',
                          ),
                        ),
                        Text(
                          'Ажилтан',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'PO дугаар',
                          ),
                        ),
                        Text(
                          '${invoice.purchaseOrder!.refCode}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нийлүүлэгч тал',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Татвар төлөгч дугаар',
                          ),
                        ),
                        Text(
                          'Дугаар',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Партнерийн нэр,',
                              ),
                            ),
                            Text(
                              'Партнер код',
                              style: TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: grey3,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Нийлүүлэгч бизнес,',
                              ),
                            ),
                            Text(
                              'Партнер код',
                              style: TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: grey3,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Нэхэмжлэх бичсэн',
                          ),
                        ),
                        Text(
                          'Огноо, цаг',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Санхүүгийн ажилтан',
                          ),
                        ),
                        Text(
                          'Санхүүгийн ажилтан',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Бизнесийн хаяг',
                          ),
                        ),
                        Text(
                          'Бизнесийн хаяг',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Дансны мэдээлэл',
                          ),
                        ),
                        Text(
                          'Дансны дугаар, нэр',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Хүлээлгэн өгсөн',
                          ),
                        ),
                        Text(
                          'Ажилтан',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'SO дугаар',
                          ),
                        ),
                        Text(
                          '${invoice.salesOrder!.refCode}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'БАРАА, ҮЙЛЧИЛГЭЭ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: invoice.invoiceLines!
                        .map(
                          (item) => InvoiceProductCard(
                            data: item,
                            color: invoiceColor,
                            general: general,
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэмэлт Тэмдэглэл',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    height: 125,
                    color: white,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey3.withOpacity(0.3),
                        ),
                      ),
                      child: Text('${invoice.description}'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      'НИЙТ ТӨЛБӨР',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Хөнгөлөлт',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(invoice.discountAmount.toString())}',
                              style: TextStyle(color: invoiceColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Тооцсон НӨАТ',
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                '${Utils().formatCurrency(invoice.vatAmount.toString())}₮',
                                style: TextStyle(color: invoiceColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Тооцсон НХАТ',
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                '${Utils().formatCurrency(invoice.taxAmount.toString())}',
                                style: TextStyle(color: invoiceColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Хүргэлт төлбөр',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(invoice.shippingAmount.toString())}',
                              style: TextStyle(color: invoiceColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'НИЙТ ТӨЛБӨР',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                // '${Utils().formatCurrency(invoice.totalAmount.toString())}₮',
                                '',
                                style: TextStyle(
                                  color: invoiceColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Хавсралт файл',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  for (var i = 0; i < 3; i++)
                    Container(
                      color: white,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Файлын нэр',
                            style: TextStyle(color: invoiceColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: grey3,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 37),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Harah.routeName,
                              arguments: HarahArguments(
                                invoice: invoice,
                                data: invoice.invoiceLines!,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.visibility_outlined,
                                color: white,
                                size: 20,
                              ),
                              Text(
                                'Харах',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              InvoicePaymentPage.routeName,
                              arguments: InvoicePaymentPageArguments(
                                data: Invoice(),
                                id: '',
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              SvgPicture.asset(
                                'images/tuloh.svg',
                                height: 14,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Төлөх',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/cancel.svg',
                                height: 17,
                                width: 17,
                              ),
                              Text(
                                'Цуцлах',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/cancel.svg',
                                height: 17,
                                width: 17,
                              ),
                              Text(
                                'Цуцлах',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, innerBoxIsScrolled) => InvoicePaymentPage(
          id: widget.id,
          data: invoice,
        ),
      );
  overdueStatus() {
    switch (invoice.overdueStatus) {
      case "NORMAL":
        return "Хэвийн";
      case "ONE_TO_THREE":
        return "1-3 хоног";
      case "FOUR_TO_THIRTY":
        return "4-30 хоног";
      case "THIRTY_ONE_TO_SIXTY":
        return "31-60 хоног";
      case "SIXTY_ONE_TO_NINETY":
        return "61-90 хоног";
      case "MORE_THAN_NINETY":
        return "91 < хоног";
    }
  }

  invoicePaymentStatus() {
    switch (invoice.paymentStatus) {
      case "PENDING":
        return "Хүлээгдэж буй";
      case "DIVIDED":
        return "Хуваасан";
      case "OVER_DUE":
        return "Хугацаа хэтэрсэн";
      case "CLOSED":
        return "Хаасан";
      default:
    }
  }

  textColor() {
    switch (invoice.paymentStatus) {
      case "PENDING":
        return yellow;
      case "DIVIDED":
        return buttonColor;
      case "OVER_DUE":
        return red;
      case "CLOSED":
        return green;
      default:
    }
  }

  invoiceStatus() {
    switch (invoice.invoiceStatus) {
      case "DRAFT":
        return "Түр төлөв";
      case "SENT":
        return "Илгээсэн";
      case "CONFIRMED":
        return "Баталсан";
      case "REJECTED":
        return "Татгалзсан";
      case "RETURNED":
        return "Буцаасан";
      case "CLOSED":
        return "Хаасан";
      default:
    }
  }

  invoiceStatusColor() {
    switch (invoice.invoiceStatus) {
      case "DRAFT":
        return grey;
      case "SENT":
        return Colors.indigo;
      case "CONFIRMED":
        return Colors.lightBlue;
      case "REJECTED":
        return red;
      case "RETURNED":
        return Colors.pink;
      case "CLOSED":
        return green;
      default:
    }
  }
}
