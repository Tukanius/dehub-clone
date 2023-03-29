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
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    color: buttonColor2,
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
                margin: const EdgeInsets.only(left: 20),
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
          Row(
            children: [
              Container(
                color: white,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Нэхэмжлэх №',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                          ),
                        ),
                        Text(
                          'INV-290812',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
