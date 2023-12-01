// import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PullSheetExpensesArguments {
  Order data;
  PullSheetExpensesArguments({
    required this.data,
  });
}

class PullSheetExpenses extends StatefulWidget {
  final Order data;
  static const routeName = '/PullSheetExpenses';
  const PullSheetExpenses({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PullSheetExpenses> createState() => _PullSheetExpensesState();
}

class _PullSheetExpensesState extends State<PullSheetExpenses> {
  onSubmit() async {
    await OrderApi().pullSheetConfirm(widget.data.id!);
    showCustomDialog(
      context,
      "Амжилттай хүлээн авлаа",
      true,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: orderColor),
        backgroundColor: white,
        title: Text(
          'Ачилтын падаан',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ShippingCard(
                    startAnimation: true,
                    index: 1,
                    data: widget.data,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'БАРААНЫ МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        color: coolGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            'Барааны мэдээлэл',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: grey3,
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '#',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Бараа',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(
                                      'Хэм.н',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      'Тоо',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    child: Text(
                                      'Нэгж үнэ',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Column(
                          children: widget.data.pullSheetLines!
                              .map(
                                (e) => OrderGoodsInfo(
                                  data: widget.data.pullSheetLines,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: Text(
                      'ПАДААНЫ ДҮН',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    labelText: "Нэр төрлийн тоо",
                    secondText: "${widget.data.pullSheetLines?.length}",
                    secondTextColor: blue,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    labelText: "Хүлээн авах барааны тоо",
                    secondTextColor: blue,
                    secondText:
                        "${widget.data.pullSheetLines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: CustomButton(
              onClick: () {
                onSubmit();
              },
              labelText: "Шалгаж хүлээн авлаа",
              labelColor: orderColor,
            ),
          )
        ],
      ),
    );
  }
}
