import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class MainInformationTab extends StatefulWidget {
  const MainInformationTab({super.key});

  @override
  State<MainInformationTab> createState() => _MainInformationTabState();
}

class _MainInformationTabState extends State<MainInformationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлтийн код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'SCF-BL-10212',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлт төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Олгосон',
                    style: TextStyle(color: green),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлтийн дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: financingColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүүжилт валют',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Төгрөг',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүүжилт хоног',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '365',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүүжилтийн шимтгэл',
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Банк шимтгэл дүн',
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бусад шимтгэл дүн',
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
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бүтээгдэхүүн код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Product_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бүтээгдэхүүн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Product_Name',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийлүүлэгч нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Supplier_Name',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийлүүлэгч код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Supplier_Ref#',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Нэхэмжлэх мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэхэмжлэх код',
                  style: TextStyle(color: dark),
                ),
                Row(
                  children: [
                    Text(
                      'INV_Ref#',
                      style: TextStyle(color: financingColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: grey3,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэх үеийн үлдэгдэл',
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Илгээсэн огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Send_Datetime',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Баталсан огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Approved_DateTime',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Худалдан авагч код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Buyer_Code',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Худалдан авагч нэр',
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
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүү ажилтан утас',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Phone_Number',
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
