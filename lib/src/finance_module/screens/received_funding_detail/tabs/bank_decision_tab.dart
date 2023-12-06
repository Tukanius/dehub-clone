import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankDecisionTab extends StatefulWidget {
  final Finance data;
  const BankDecisionTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<BankDecisionTab> createState() => _BankDecisionTabState();
}

class _BankDecisionTabState extends State<BankDecisionTab> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

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
                  'Банк хариу огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Огноо, цаг',
                  style: TextStyle(color: source.currentColor),
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
                  'Олголтын шийдвэр',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff2290FF).withOpacity(0.2),
                  ),
                  child: Text(
                    'Баталсан',
                    style: TextStyle(
                      color: Color(0xff2290FF),
                    ),
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
                  'Банк ажилтан',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Bank user',
                  style: TextStyle(color: source.currentColor),
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
                  'Олгох дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: source.currentColor,
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
                  'Татах SCF шимтгэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: source.currentColor,
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
                  'Татах банк шимтгэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: source.currentColor,
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
                  'Татах бусад шимтгэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: source.currentColor,
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
                  'Шийдвэрлэсэн огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Огноо, цаг',
                  style: TextStyle(color: source.currentColor),
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
                  'Олгох огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Огноо, цаг',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Эргэн төлөлтийн мэдээлэл',
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
                Container(
                  width: 150,
                  child: Text(
                    'Эргэн төлөлтийн нэхэмжлэх',
                    style: TextStyle(color: dark),
                  ),
                ),
                Text(
                  'REP_INV_100042',
                  style: TextStyle(
                    color: source.currentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: white,
            child: Row(
              children: [
                Icon(Icons.downloading_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'INV_32093282.PDF',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff151357),
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
                  'Эргэн төлөх дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'XXX,XXX,XXX.00 ₮',
                  style: TextStyle(
                    color: source.currentColor,
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
                  'Эргэн төлөх огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Огноо, цаг',
                  style: TextStyle(
                    color: source.currentColor,
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
    );
  }
}
