import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
// import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderGoodsInfo extends StatefulWidget {
  final List<Order>? data;
  const OrderGoodsInfo({
    this.data,
    super.key,
  });

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
            child: const Text(
              'Барааны мэдээлэл',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: grey3,
              ),
            ),
          ),
          const Divider(),
          const Row(
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
          const Divider(),
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
                              style: const TextStyle(
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
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                ),
                                children: [
                                  TextSpan(text: data.name),
                                  TextSpan(text: " ${data.skuCode} "),
                                  data.brand != null
                                      ? TextSpan(text: "${data.brand}")
                                      : const TextSpan(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${data.unit?[0]}'.toLowerCase(),
                              style: const TextStyle(
                                color: black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: data.quantity == null
                                ? const Text('0')
                                : data.isConfirmed == true
                                    ? Text(
                                        '${data.confirmedQuantity?.toInt()}',
                                        style: const TextStyle(
                                          color: black,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        '${data.quantity?.toInt()}',
                                        style: const TextStyle(
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
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : const Text(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
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
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : const Text(
                                  '-',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
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
