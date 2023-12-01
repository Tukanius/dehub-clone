import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
// import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderGoodsInfo extends StatefulWidget {
  final List<Order>? data;
  OrderGoodsInfo({
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderGoodsInfo> createState() => _OrderGoodsInfoState();
}

class _OrderGoodsInfoState extends State<OrderGoodsInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      margin: const EdgeInsets.symmetric(horizontal: 5),
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
                flex: 2,
                child: Text(
                  '#',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  'Бараа',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Хэм.н',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Тоо',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'Нэгж үнэ',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Divider(),
          Column(
            children: widget.data!
                .map(
                  (data) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${widget.data!.indexOf(data) + 1} ',
                              style: TextStyle(
                                color: black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                ),
                                children: [
                                  TextSpan(text: data.name),
                                  TextSpan(text: " ${data.skuCode} "),
                                  data.brand != null
                                      ? TextSpan(text: "${data.brand}")
                                      : TextSpan(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${data.unit?[0]}'.toLowerCase(),
                              style: TextStyle(
                                color: black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: data.quantity == null
                                ? Text('0')
                                : data.isConfirmed == true
                                    ? Text(
                                        '${data.confirmedQuantity?.toInt()}',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        '${data.quantity?.toInt()}',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                          ),
                          Expanded(
                            flex: 5,
                            child: data.price != null
                                ? Text(
                                    '${Utils().formatCurrency(data.price.toString())}₮',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    '-',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Нийт:  ',
                            style: TextStyle(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          data.totalAmount != null
                              ? Text(
                                  '${Utils().formatCurrency(data.totalAmount.toString())}₮',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  '-',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
