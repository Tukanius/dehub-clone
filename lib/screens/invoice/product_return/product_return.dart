import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
import 'package:dehub/screens/invoice/payment_page/payment_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductReturnPageArguments {
  String id;
  ProductReturnPageArguments({
    required this.id,
  });
}

class ProductReturnPage extends StatefulWidget {
  final String id;
  static const routeName = '/productreturnpage';
  const ProductReturnPage({super.key, required this.id});

  @override
  State<ProductReturnPage> createState() => _ProductReturnPageState();
}

class _ProductReturnPageState extends State<ProductReturnPage>
    with AfterLayoutMixin {
  Invoice invoice = Invoice();

  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);

    setState(() {
      isLoading = false;
    });
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

  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).general;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: invoiceColor,
        title: Text(
          'Буцах',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                '${invoice.refCode}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Үүссэн: ${invoice.getsentDate()}',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'НЭХЭМЖЛЭГЧ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.perm_contact_cal_outlined,
                                        color: invoiceColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${invoice.senderBusiness!.partner!.businessNameEng}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Партнерийн нэр',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.senderBusiness!.partner!.businessNameEng}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Салбарын нэр',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.senderBranch!.nameEng}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'ХАРИЛЦАГЧ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.perm_contact_cal_outlined,
                                        color: invoiceColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Харилцагч сонгох',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    // showModalBottomSheet(
                                    //   useSafeArea: true,
                                    //   isScrollControlled: true,
                                    //   context: context,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.vertical(
                                    //       top: Radius.circular(20),
                                    //     ),
                                    //   ),
                                    //   builder: (context) => buildSheet(),
                                    // );
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Хүргэлтийн хаяг',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('${invoice.senderBranch!.name}'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх хүлээн авагч',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        '${invoice.receiverBusiness!.partner!.businessNameEng}'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх статус',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      invoiceStatus(),
                                      style: TextStyle(
                                        color: invoiceStatusColor(),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Баталсан',
                                  ),
                                ),
                                Row(
                                  children: [
                                    invoice.invoiceStatus == "CONFIRMED"
                                        ? Text(
                                            '${invoice.confirmedUser!.firstName}',
                                          )
                                        : Text(
                                            '-',
                                          ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'ЗАХИАЛГА',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'PO дугаар',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.purchaseOrder!.refCode}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'SO дугаар',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.salesOrder!.refCode}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Борлуулагч',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.senderFinUser!.firstName}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'БАРАА, ҮЙЛЧИЛГЭЭ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: invoice.invoiceLines!
                            .map(
                              (item) => InvoiceProductCard(
                                data: item,
                                color: invoiceColor,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 10,
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        color: white,
                        child: Column(
                          children: [
                            Row(
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
                                      '${invoice.discountAmount}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нийт дүн',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '${invoice.itemsTotal}',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
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
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '${invoice.vatAmount}₮',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
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
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '${invoice.taxAmount}',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                      '${invoice.shippingAmount}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '${invoice.totalAmount} ',
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
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Нэмэлт Тэмдэглэл',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        height: 125,
                        color: white,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff636E72).withOpacity(0.3),
                            ),
                          ),
                          child: Text('${invoice.description}'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'ТӨЛБӨРИЙН МЭДЭЭЛЭЛ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх үлдэгдэл',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.amountToPay}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Төлөх хугацаа',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.getPaymentDate()}',
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Төлбөрийн төлөв',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      invoicePaymentStatus(),
                                      style: TextStyle(
                                        color: textColor(),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Баталсан дүн',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.confirmedAmount}',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Хугацаа хэтрэлт',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.overDueStatus}',
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 37),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: black,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Harah.routeName);
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
                            SizedBox(
                              width: 50,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  backgroundColor: transparent,
                                  context: context,
                                  builder: (context) => buildSheet(),
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
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, innerBoxIsScrolled) => PaymentPage(
          id: widget.id,
          data: invoice,
        ),
      );
}
