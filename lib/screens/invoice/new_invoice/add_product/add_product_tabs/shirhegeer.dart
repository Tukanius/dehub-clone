import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Shirhegeer extends StatefulWidget {
  static const routeName = '/Shirhegeer';
  const Shirhegeer({super.key});

  @override
  State<Shirhegeer> createState() => _ShirhegeerState();
}

class _ShirhegeerState extends State<Shirhegeer> {
  int price = 9500;
  int amount = 1000;
  int percent = 5;
  int _count = 00;
  String? discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              color: white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        child: Image(
                          image: AssetImage(
                            'images/map.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Гүзээлзгэнэтэй иогурт',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text(
                              'SKU 32165456, Brand Name, 250 гр, савлагааны нэр боөрсорыбх',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'images/close.svg',
                        color: grey3,
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Нэгж үнэ',
                              style: TextStyle(
                                color: Color(0xff8181A5),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${price} ₮',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1 кг',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Хөнгөлөлт',
                              style: TextStyle(
                                color: Color(0xff8181A5),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${amount} ₮',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff636E72).withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffEBFAFA),
                              ),
                              child: Text(
                                'дүн',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: grey2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_count > 0) {
                                _count--;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 18),
                            decoration: BoxDecoration(
                              border: Border.all(color: buttonColor),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: buttonColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(
                              left: 46, right: 5, top: 8, bottom: 11),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffD9DCDE),
                            ),
                          ),
                          child: Text(
                            '${_count}',
                            style: TextStyle(color: grey3, fontSize: 20),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _count++;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 18),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              border: Border.all(color: buttonColor),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Icon(
                              Icons.add,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дүн:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: grey2,
                        ),
                      ),
                      Text(
                        '${(price - amount) * _count} ₮',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: grey2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              color: white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        child: Image(
                          image: AssetImage(
                            'images/map.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Гүзээлзгэнэтэй иогурт',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text(
                              'SKU 32165456, Brand Name, 250 гр, савлагааны нэр боөрсорыбх',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'images/close.svg',
                        color: grey3,
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Нэгж үнэ',
                              style: TextStyle(
                                color: Color(0xff8181A5),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${price} ₮',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1 кг',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Хөнгөлөлт',
                              style: TextStyle(
                                color: Color(0xff8181A5),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${percent} %',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff636E72).withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffEBFAFA),
                              ),
                              child: Text(
                                'хувь',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: grey2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_count > 0) {
                                _count--;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 18),
                            decoration: BoxDecoration(
                              border: Border.all(color: buttonColor),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: buttonColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(
                              left: 46, right: 5, top: 8, bottom: 11),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffD9DCDE),
                            ),
                          ),
                          child: Text(
                            '${_count}',
                            style: TextStyle(color: grey3, fontSize: 20),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _count++;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 18),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              border: Border.all(color: buttonColor),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Icon(
                              Icons.add,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дүн:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: grey2,
                        ),
                      ),
                      Text(
                        '${(price - (price * percent) / 100) * _count} ₮',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: grey2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: white,
                        ),
                        Text(
                          'Сонгосонг нэмэх',
                          style: TextStyle(
                            fontSize: 10,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    child: VerticalDivider(
                      color: white,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.card_travel,
                                color: white,
                              ),
                              Text(
                                'Ердийн үнэ',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.card_giftcard_rounded,
                                color: white,
                              ),
                              Text(
                                'Урамшуулал',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
