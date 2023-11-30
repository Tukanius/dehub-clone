import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GoodsInfoCard extends StatefulWidget {
  final List<Invoice> data;
  GoodsInfoCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<GoodsInfoCard> createState() => _GoodsInfoCardState();
}

class _GoodsInfoCardState extends State<GoodsInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Барааны мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Divider(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '#',
                        style: TextStyle(
                          fontSize: 12,
                          color: black,
                        ),
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Хэм.н',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Тоо',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Нэгж үнэ',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: widget.data
                      .map(
                        (data) => Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${widget.data.indexOf(data) + 1} ',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    '${data.nameMon} SKU ${data.skuCode}',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ш',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: data.quantity == null
                                      ? Text('0')
                                      : Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${data.quantity?.toInt()}',
                                            style: TextStyle(
                                              color: black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${Utils().formatCurrency(data.price.toString())}₮',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
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
                                  'Нийт',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${Utils().formatCurrency("${double.parse(data.price.toString()) * double.parse(data.quantity!.toString())}")}₮',
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
                              height: 15,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
