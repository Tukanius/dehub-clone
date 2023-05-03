import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Index1 extends StatefulWidget {
  static const routeName = '/index1';
  const Index1({Key? key}) : super(key: key);

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    '2022-01-17 15:24 PM,',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Ch.Gerelmaa',
                    style: TextStyle(
                      color: brownButtonColor,
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  color: white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          'Нэхэмжлэх №',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Бүртгэсэн',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Төлбөрийн сонголт',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Нэхэмжлэх баталсан',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Төлөх сүүлийн өдөр',
                          style: TextStyle(
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
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            'INV-290812',
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            '2021-12-02',
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            '2 хоногт',
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            '2021-12-04',
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
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
                          'Supplier_Business_Name',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ТТД: 123123',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Партнерын нэр',
                          style: TextStyle(
                            color: brownButtonColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'mail@tradegroup.mn',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '+976 - 9999 9999',
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
                          'Buyer_Business_Name',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ТТД: 123123',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Партнерын нэр',
                          style: TextStyle(
                            color: brownButtonColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'mail@tradegroup.mn',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '+976 - 9999 9999',
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
                        color: Color(0xff636E72),
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          '#',
                          style: TextStyle(
                            fontSize: 12,
                            color: black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Text(
                          'Бараа',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
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
                  Divider(),
                  for (var i = 1; i < 6; i++)
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${i}',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                width: 160,
                                child: Text(
                                  'Талын Монгол банш, 900гр'
                                  'Хонины махтай, ууттай,'
                                  'SKU 321312313',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'ш',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '₮ 13240.00',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  'Нийт',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  '₮ 66200.00',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      color: Color(0xff636E72),
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
                                  color: brownButtonColor,
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
                                  color: brownButtonColor,
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
                                  color: brownButtonColor,
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
                                  color: brownButtonColor,
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
                                  color: brownButtonColor,
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
                                  color: brownButtonColor,
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
