import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Index0 extends StatefulWidget {
  const Index0({Key? key}) : super(key: key);

  @override
  _Index0State createState() => _Index0State();
}

class _Index0State extends State<Index0> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              left: 15,
            ),
            child: Text(
              'ЕРӨНХИЙ МЭДЭЭЛЭЛ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дансны товч нэр',
                  style: TextStyle(color: dark),
                ),
                Row(
                  children: [
                    Text(
                      'Delgereh',
                      style: TextStyle(color: neonGreen),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('images/edit.svg'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Банкны нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Голомт банк',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дансны нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Дэлгэрэх хүнс',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дансны дугаар',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '521****513',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дансны валют',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Төгрөг',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Одоогийн үлдэгдэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '30,000.00 ₮',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'БҮРТГЭЛИЙН МЭДЭЭЛЭЛ',
              style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бүртгэсэн ажилтан',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'B.Bolormaa',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бүртгэсэн огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '2021-11-13 17:13 PM',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                    }),
              ),
              Text(
                'Үндсэн данс',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
