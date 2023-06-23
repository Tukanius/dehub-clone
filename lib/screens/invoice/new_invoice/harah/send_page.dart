import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendPage extends StatefulWidget {
  static const routeName = '/sendpage';
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: invoiceColor,
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              'images/close.svg',
            ),
          ),
        ),
        title: Text(
          'INV - 23987 - илгээх',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, left: 16, bottom: 10),
                  child: Text(
                    'ХҮЛЭЭН АВАГЧ',
                    style: TextStyle(
                      color: grey3,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Buyer нэр'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Bolor Store',
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
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('И-мэйл хаяг'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'bolor@gmail.com',
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
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Нэхэмжлэх дүн'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '417,450.00 ₮',
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
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хавсралт'),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Invoice-23987.PDF',
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
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    'ИЛГЭЭГЧ',
                    style: TextStyle(
                      color: grey3,
                      fontSize: 14,
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
                            'Supplier Business Name',
                            style: TextStyle(color: invoiceColor),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: grey3,
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
                            'Партнер нэр',
                            style: TextStyle(color: invoiceColor),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: grey3,
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
                            'Салбарын нэр',
                            style: TextStyle(color: invoiceColor),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: grey3,
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
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Нэмж бичих зүйлс',
                    style: TextStyle(color: black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                labelText: 'Нэхэмжлэл илгээх',
                onClick: () {},
                labelColor: invoiceColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
