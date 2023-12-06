import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderCbdPayment extends StatefulWidget {
  static const routeName = '/OrderCbdPayment';
  const OrderCbdPayment({Key? key}) : super(key: key);

  @override
  State<OrderCbdPayment> createState() => _OrderCbdPaymentState();
}

class _OrderCbdPaymentState extends State<OrderCbdPayment> {
  List<Order> field = [
    Order(
      firstName: "Нэхэмжлэх №",
      lastName: 'INV_232323',
    ),
    Order(
      firstName: "Захиалгын дүн",
      lastName: '161,000₮',
    ),
    Order(
      firstName: "Хүлээн авсан дүн",
      lastName: '161,000₮',
    ),
    Order(
      firstName: "Төлсөн дүн",
      lastName: '161,000₮',
    ),
    Order(
      firstName: "Нэхэмжлэхийн дүн",
      lastName: '161,000₮',
    ),
    Order(
      firstName: "Төлбөрийн нөхцөл",
      lastName: 'Урьдчилсан',
    ),
    Order(
      firstName: "Төлөх огноо цаг",
      lastName: '-',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        elevation: 0,
        leading: CustomCloseButton(),
        title: Text(
          'Захиалгын төлбөр төлөх',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Төлбөрийн мэдээлэл',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: grey2,
              ),
            ),
          ),
          Column(
            children: field
                .map(
                  (e) => FieldCard(
                    marginHorizontal: 15,
                    marginVertical: 15,
                    labelText: e.firstName,
                    secondText: e.lastName,
                    secondTextColor: orderColor,
                    fontWeight: e.firstName == "Нэхэмжлэхийн дүн"
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: white,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 100,
          ),
          CustomButton(
            onClick: () {},
            labelColor: orderColor,
            labelText: "Ок, еБаримт авъя",
          ),
        ],
      ),
    );
  }
}
