import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class TransactionDetailPage extends StatefulWidget {
  static const routeName = 'transactiondetailpage';
  const TransactionDetailPage({Key? key}) : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: neonGreen,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              '521****513',
              style: TextStyle(
                  color: neonGreen, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Голомт банк, Дэлгэрэх хүнс',
              style: TextStyle(
                color: grey2,
                fontSize: 15,
              ),
            ),
          ),
          Divider(
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Гүйлгээний лавлах',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Transref#',
                  style: TextStyle(
                      color: grey2, fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Огноо, цаг',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '2023-01-23 12:23 PM',
                  style: TextStyle(
                      color: grey2, fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Гүйлгээний төрөл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'B2B нэхэмжлэх',
                  style: TextStyle(
                      color: grey2, fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Төлбөрийн хэрэгсэл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'DeHUB B2B',
                  style: TextStyle(
                      color: grey2, fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Гүйлгээний дүн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '30,000.00 ₮',
                  style: TextStyle(color: red),
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
                  'Валют',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Төгрөг',
                  style: TextStyle(
                      color: grey2, fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Гүйлгээний утга',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'Амжилттай',
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
                  'Гүйлгээ хийсэн',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'B.Bolormaa',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Text(
              'ХАРЬЦСАН ДАНС',
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
                  'Дансны дугаар',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '32332094823',
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
                  'Гүрүн трэйд ХХК',
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
        ],
      ),
    );
  }
}
