import 'package:dehub/components/goods_info_card/goods_info_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class Index1 extends StatefulWidget {
  final Invoice invoice;
  final bool isNewInvoice;
  static const routeName = '/index1';
  const Index1({
    required this.isNewInvoice,
    required this.invoice,
    Key? key,
  }) : super(key: key);

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> with AfterLayoutMixin {
  User user = User();
  Invoice supplierBusiness = Invoice();
  Invoice buyerBusiness = Invoice();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    if (widget.isNewInvoice == false) {
      supplierBusiness = widget.invoice.type == "SALES"
          ? widget.invoice.senderBusiness!
          : widget.invoice.receiverBusiness!;
      buyerBusiness = widget.invoice.type == "SALES"
          ? widget.invoice.receiverBusiness!
          : widget.invoice.senderBusiness!;
    } else {
      buyerBusiness = widget.invoice.receiverBusiness!;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: invoiceColor,
            ),
          )
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      text: TextSpan(
                        style:
                            TextStyle(fontFamily: 'Montserrat', color: black),
                        children: [
                          TextSpan(
                            text:
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())} ',
                          ),
                          user.lastName != null
                              ? TextSpan(text: '${user.lastName?[0]} ')
                              : TextSpan(),
                          TextSpan(
                            text: "${user.firstName} ",
                            style: TextStyle(
                              color: invoiceColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: 'үүсгэсэн.'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 25, bottom: 10),
                    child: Text(
                      'НЭХЭМЖЛЭХ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Нэхэмжлэх №',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.refCode == null
                                  ? Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      '${widget.invoice.refCode}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Бүртгэсэн',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Төлбөрийн сонголт',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.paymentTerm?.description !=
                                      null
                                  ? Text(
                                      '${widget.invoice.paymentTerm?.description}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Нэхэмжлэх баталсан',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.createdAt != null
                                  ? Text(
                                      '${DateFormat("yyyy-MM-dd").format(widget.invoice.createdAt!)}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      "-",
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Төлөх сүүлийн өдөр',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.paymentDate != null
                                  ? Text(
                                      '${DateFormat("yyyy-MM-dd").format(widget.invoice.paymentDate!)}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нэхэмжлэгч:',
                        style: TextStyle(
                          color: Color(0xff8181A5),
                        ),
                      ),
                      Text(
                        'Төлбөр төлөгч:',
                        style: TextStyle(
                          color: Color(0xff8181A5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: widget.isNewInvoice == false
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${supplierBusiness.partner?.businessName}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'ТТД: ${supplierBusiness.regNumber}',
                                      style: TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.profileName}',
                                      style: TextStyle(
                                        color: invoiceColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.partner?.email}',
                                      style: TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.partner?.phone}',
                                      style: TextStyle(color: black),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.currentBusiness?.partner?.businessName}',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'ТТД: ${user.currentBusiness?.regNumber}',
                                      style: TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.currentBusiness?.profileName}',
                                      style: TextStyle(
                                        color: invoiceColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.currentBusiness?.partner?.email}',
                                      style: TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.currentBusiness?.partner?.phone}',
                                      style: TextStyle(color: black),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${buyerBusiness.partner?.businessName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ТТД: ${buyerBusiness.regNumber}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.profileName}',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.partner?.email}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.partner?.phone}',
                                style: TextStyle(color: black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GoodsInfoCard(
                    data: widget.invoice.lines!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хөнгөлөлт'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.discountAmount.toString())} ₮',
                              style: TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: grey2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Нийт дүн'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '${Utils().formatCurrency(widget.invoice.itemsTotal.toString())} ₮',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Тооцсон НӨАТ'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '${Utils().formatCurrency(widget.invoice.vatAmount.toString())} ₮',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Тооцсон НХАТ'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '${Utils().formatCurrency(widget.invoice.taxAmount.toString())}₮',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хүргэлт төлбөр'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '${Utils().formatCurrency("${widget.invoice.shippingAmount}")}₮',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: grey2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.totalAmount.toString())} ₮',
                              style: TextStyle(
                                color: invoiceColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
  }
}
