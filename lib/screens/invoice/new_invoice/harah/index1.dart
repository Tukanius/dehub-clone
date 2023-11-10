import 'package:dehub/api/invoice_api.dart';
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
  final double totalAmount;
  final List<Invoice>? data;
  static const routeName = '/index1';
  const Index1({
    required this.totalAmount,
    required this.invoice,
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> with AfterLayoutMixin {
  User user = User();
  Invoice invoice = Invoice();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().networkGet(widget.invoice.id!);
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
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${user.lastName?[0]}.${user.firstName}',
                          style: TextStyle(
                            color: invoiceColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('үүсгэсэн')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'НЭХЭМЖЛЭХ',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 160,
                          padding: const EdgeInsets.only(left: 15),
                          color: white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  'Нэхэмжлэх №',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8181A5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  'Бүртгэсэн',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8181A5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 30,
                                child: Text(
                                  'Төлбөрийн сонголт',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8181A5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  'Нэхэмжлэх баталсан',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8181A5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  'Төлөх сүүлийн өдөр',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8181A5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            color: white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 20,
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Text(
                                    '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  child: Text(
                                    '${invoice.paymentTerm?.description}',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Text(
                                    '${DateFormat("yyyy-MM-dd").format(invoice.paymentDate!)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.currentBusiness?.profileName}',
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
                                '${user.currentBusiness?.partnerName}',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${user.currentBusiness?.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${user.currentBusiness?.partnerPhone}',
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
                                '${widget.invoice.partner?.businessName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ТТД: ${widget.invoice.regNumber}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice.partnerName}',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice.partnerPhone}',
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
                  Container(
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            'Барааны мэдээлэл',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: grey3,
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '#',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Бараа',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(
                                      'Хэм.н',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      'Тоо',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    child: Text(
                                      'Нэгж үнэ',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Column(
                          children: widget.data!
                              .map(
                                (e) => GoodsInfoCard(
                                  index: widget.data?.indexOf(e),
                                  data: e,
                                ),
                              )
                              .toList(),
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хөнгөлөлт'),
                        Row(
                          children: [
                            Text(
                              '25,500 ₮',
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Нийт дүн'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '379,500.00 ₮',
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Тооцсон НӨАТ'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '37,95.00 ₮',
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Тооцсон НХАТ'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '00.00 ₮',
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хүргэлт төлбөр'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '00.00 ₮',
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
                              '${Utils().formatCurrency(widget.totalAmount.toString())} ₮',
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
