import 'package:dehub/api/payment_api.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class TransactionDetailPageArguments {
  Payment data;
  TransactionDetailPageArguments({
    required this.data,
  });
}

class TransactionDetailPage extends StatefulWidget {
  final Payment data;
  static const routeName = '/transactiondetailpage';
  const TransactionDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage>
    with AfterLayoutMixin {
  Payment payment = Payment();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    payment = await PaymentApi().transactionGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: paymentColor,
          ),
        ),
        // bottom: PreferredSize(
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 5),
        //     color: paymentColor,
        //     height: 2.0,
        //   ),
        //   preferredSize: Size.fromHeight(3.0),
        // ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: paymentColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      '521****513',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Голомт банк',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                              color: grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                              color: grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                              color: grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                              color: grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                              color: grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Text(
                      'ХАРЬЦСАН ДАНС',
                      style:
                          TextStyle(color: grey3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
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
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
