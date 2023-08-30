import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/goods_info_card/goods_info_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class Index1 extends StatefulWidget {
  final Invoice? invoice;
  final List<Invoice>? data;
  static const routeName = '/index1';
  const Index1({
    this.invoice,
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> with AfterLayoutMixin {
  Partner partner = Partner();
  Invoice invoice = Invoice();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().networkGet(widget.invoice!.id!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
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
                          '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${partner.user?.lastName?[0]}.${partner.user?.firstName}',
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
                                    '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
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
                                    '${Moment.parse(invoice.paymentDate.toString()).format("YYYY-MM-DD")}',
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
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${partner.user?.currentBusiness?.profileName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ТТД: ${partner.user?.currentBusiness?.regNumber}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${partner.user?.currentBusiness?.partnerName}',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${partner.user?.currentBusiness?.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${partner.user?.currentBusiness?.partnerPhone}',
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
                                '${widget.invoice?.partner?.businessName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ТТД: ${widget.invoice?.regNumber}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice?.partnerName}',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice?.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.invoice?.partnerPhone}',
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
                                  index: widget.data!.indexOf(e),
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
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Хөнгөлөлт'),
                              Container(
                                child: Row(
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        Container(
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
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      '417,450.00 ₮',
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
                              ),
                            ],
                          ),
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
