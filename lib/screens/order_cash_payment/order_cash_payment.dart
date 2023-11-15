import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/screens/order_cash_approval/order_cash_approval.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCashPayment extends StatefulWidget {
  static const routeName = '/OrderCashPayment';
  const OrderCashPayment({Key? key}) : super(key: key);

  @override
  State<OrderCashPayment> createState() => _OrderCashPaymentState();
}

class _OrderCashPaymentState extends State<OrderCashPayment> {
  bool isLoading = false;
  List<Order> list = [
    Order(
      firstName: "Нэхэмжлэх №",
      lastName: "INV_243242",
    ),
    Order(
      firstName: "Нэхэмжлэх дүн",
      lastName: "141,000₮",
    ),
    Order(
      firstName: "Төлсөн дүн",
      lastName: "0₮",
    ),
    Order(
      firstName: "Төлөх дүн",
      lastName: "141,000₮",
    ),
    Order(
      firstName: "Төлөх огноо, цаг",
      lastName: "2023-02-28 15:00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: CustomCloseButton(),
        backgroundColor: orderColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Захиалгын төлбөр төлөх',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Төлбөрийн мэдээлэл',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: list
                  .map(
                    (e) => FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 15,
                      color: white,
                      labelText: e.firstName,
                      secondText: e.lastName,
                      labelTextColor: grey2,
                      secondTextColor: orderColor,
                    ),
                  )
                  .toList(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Төлбөрийн хэлбэр',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              color: white,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/sanhuujilt.svg',
                    colorFilter: ColorFilter.mode(orderColor, BlendMode.srcIn),
                    height: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Бэлэн мөнгөөр',
                    style: TextStyle(color: orderColor),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Бэлэн тооцоо',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Олгосон мөнгөн дүн",
                      style: TextStyle(
                        color: dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FormTextField(
                      initialValue: '145,000₮',
                      inputType: TextInputType.number,
                      textColor: orderColor,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      name: "totalAmount",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Авсан хариулт",
                      style: TextStyle(
                        color: dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FormTextField(
                      initialValue: '4,000₮',
                      inputType: TextInputType.number,
                      textColor: orderColor,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      name: "asdf",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Төлсөн дүн",
                      style: TextStyle(
                        color: dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FormTextField(
                      initialValue: '141,000₮',
                      inputType: TextInputType.number,
                      textColor: orderColor,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      name: "paidAmount",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Зөрүү",
                      style: TextStyle(
                        color: dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FormTextField(
                      initialValue: '-',
                      inputType: TextInputType.number,
                      textColor: orderColor,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      name: "difference",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55,
            ),
            CustomButton(
              onClick: () {
                Navigator.of(context).pushNamed(OrderCashApproval.routeName);
              },
              labelColor: orderColor,
              labelText: 'Бэлэн төлбөр батлуулах',
            ),
          ],
        ),
      ),
    );
  }
}
