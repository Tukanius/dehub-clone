import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainInfoTab extends StatefulWidget {
  const MainInfoTab({super.key});

  @override
  State<MainInfoTab> createState() => _MainInfoTabState();
}

class _MainInfoTabState extends State<MainInfoTab> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Эргэн төлөлтийн нэхэмжлэх',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ЭТН код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'REP_INV_100064',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Үүссэн огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '2023-01-12 16:22',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Эргэн төлөх огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '2023-09-12',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ЭТН дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлсөн дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлбөрийн үлдэгдэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүүжилт авсан огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '2023-09-12',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ЭТН төлөлт төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: yellow.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хүлээж буй',
                    style: TextStyle(
                      color: yellow,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ЭТН хугацаа хэтрэлт',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хэвийн',
                    style: TextStyle(
                      color: green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хугацаа хэтэрсэн хоног',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '0',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хэтрэлтийн мэдээлэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '0',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Хөтөлбөрийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хөтөлбөрийн код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Program_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хөтөлбөрийн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Program_Name',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Буцаан дуудах эсэх',
                  style: TextStyle(color: dark),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: Color(0xff151357),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Буцаан дуудсан',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Үгүй',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэхэмжлэх код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Invoice_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Олголтын код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Dis_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлтийн төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Худалдан авагч тал',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийлүүлэгч нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Buyer_Name',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийлүүлэгч код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Buyer_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнер нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Partner_Name',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнер код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Partner_ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
