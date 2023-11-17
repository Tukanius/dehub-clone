import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Эргэн төлөлтийн нэхэмжлэх',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'ЭТН код',
            secondText: 'REP_INV_100064',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Үүссэн огноо, цаг',
            secondText: '2023-01-12 16:22',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Эргэн төлөх огноо',
            secondText: '2023-01-12 16:22',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'ЭТН дүн',
            secondText: '0.00₮',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Төлсөн дүн',
            secondText: '0.00₮',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Төлбөрийн үлдэгдэл',
            secondText: '0.00₮',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилт авсан огноо',
            secondText: '2023-09-12',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ЭНТ төлөлт төлөв'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: yellow.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хүлээж буй',
                    style: TextStyle(
                      color: yellow,
                      fontSize: 12,
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
                Text('ЭТН хугацаа хэтрэлт'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хэвийн',
                    style: TextStyle(
                      color: green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацаа хэтэрсэн хоног',
            secondText: '0',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацаа хэтрэлтийн мэдээлэл',
            secondText: '0',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Хөтөлбөрийн мэдээлэл',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн код',
            secondText: 'Program_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: 'Program_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Буцаан дуудах эсэх'),
                CustomSwitch(
                  color: Color(0xff151357),
                  isDefault: true,
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Буцаан дуудсан',
            secondText: 'Үгүй',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэхэмжлэх код',
            secondText: 'Invoice_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: 'Fin_Req_#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: 'Dis_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ЭТН хугацаа хэтрэлт'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Худалдан авагч тал',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч нэр',
            secondText: 'Buyer_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч код',
            secondText: 'Buyer_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер нэр',
            secondText: 'Partner_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер код',
            secondText: 'Partner_ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
