import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Дэлгэрэх хүнс ХХК',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 6, top: 10),
                    child: Text(
                      'Bolor Delguur',
                      style: TextStyle(
                        fontSize: 16,
                        color: grey3,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              'ЕРӨНХИЙ МЭДЭЭЛЭЛ',
              style: TextStyle(
                color: Color(
                  0xff636E72,
                ),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Нийтэд нээлттэй гарах хаягийн мэдээлэл',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff636E72),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              'Аймаг, нийслэл',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              'Улаанбаатар',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              'Дүүрэг, сум',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              'Сонгино хайрхан',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              'Хороо',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              '17-р хороо',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              'Баг хороолол',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              'Цолмон хороолол',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              'Байр байшин',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              'Баялаг плаза',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              'Хаалга, тоот',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: Text(
              '3 давхар, 312 тоот',
              style: TextStyle(
                fontSize: 14,
                color: grey3,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Байршлын мэдээлэл',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Image(
            image: AssetImage(
              'images/map.jpg',
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
