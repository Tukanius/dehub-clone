import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCashApproval extends StatefulWidget {
  static const routeName = '/OrderCashApproval';
  const OrderCashApproval({Key? key}) : super(key: key);

  @override
  State<OrderCashApproval> createState() => _OrderCashApprovalState();
}

class _OrderCashApprovalState extends State<OrderCashApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        elevation: 0,
        title: Text(
          "Бэлэн төлбөр батлах",
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: white,
          ),
        ),
        actions: [
          Center(
            child: Text(
              'CN-3232',
              style: TextStyle(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    color: orderColor,
                    child: Text(
                      "ОРЛОГО",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: white,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Орлого авсан:',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Төлбөр төлсөн:',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Огноо, цаг:',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Төлсөн дүн:',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Х.Баярбат',
                      style: TextStyle(
                        color: orderColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ч.Болормаа',
                      style: TextStyle(
                        color: orderColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2023-02-28 15:12',
                      style: TextStyle(
                        color: orderColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '141,000₮',
                      style: TextStyle(
                        color: orderColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset('assets/svg/sand_time.svg'),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Б.Баярбат ',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'бэлэн орлого авснаа баталгаажуулахыг хүлээж байна',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}