import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class LimitTab extends StatefulWidget {
  final Finance data;
  const LimitTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<LimitTab> createState() => _LimitTabState();
}

class _LimitTabState extends State<LimitTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Баталсан лимит',
            secondText: 'Дүн',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Боломжит лимит',
            secondText: 'Дүн',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Лимин шаардлага',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хангасан',
                    style: TextStyle(color: green, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Лимит ашигласан',
            secondText: 'Дүн',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Олголт хүлээж буй',
            secondText: 'Дүн',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлт илгээсэн',
            secondText: 'Дүн',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Лимит ашигласан',
            secondText: 'Тоо',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Олголт хүлээж буй',
            secondText: 'Тоо',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлт илгээсэн',
            secondText: 'Тоо',
            secondTextColor: financingColor,
            color: white,
          ),
        ],
      ),
    );
  }
}
