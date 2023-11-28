import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
// import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderGoodsInfo extends StatefulWidget {
  final int? index;
  final Order? data;
  final bool? isConfirmed;
  OrderGoodsInfo({
    this.data,
    Key? key,
    this.isConfirmed,
    this.index,
  }) : super(key: key);

  @override
  State<OrderGoodsInfo> createState() => _OrderGoodsInfoState();
}

class _OrderGoodsInfoState extends State<OrderGoodsInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        '${widget.index! + 1} ',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: black,
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                          children: [
                            TextSpan(text: widget.data?.name),
                            TextSpan(text: " ${widget.data?.skuCode} "),
                            widget.data?.brand != null
                                ? TextSpan(text: "${widget.data?.brand}")
                                : TextSpan(),
                          ],
                        ),
                      ),
                      // Text(
                      //   '${widget.data?.name} SKU ${widget.data?.skuCode} ${widget.data?.brand}',
                      //   style: TextStyle(
                      //     color: black,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${widget.data?.unit?[0]}'.toLowerCase(),
                          style: TextStyle(
                            color: black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: widget.data?.quantity == null
                            ? Text('0')
                            : widget.data?.isConfirmed == true
                                ? Text(
                                    '${widget.data?.confirmedQuantity?.toInt()}',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    '${widget.data?.quantity?.toInt()}',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                      ),
                      Expanded(
                        child: widget.data?.price != null
                            ? Text(
                                '${Utils().formatCurrency(widget.data?.price.toString())}₮',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.end,
                              )
                            : Text(
                                '-',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.end,
                              ),
                      ),
                    ],
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
                'Нийт:  ',
                style: TextStyle(
                  color: black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widget.data?.totalAmount != null
                  ? Text(
                      '${Utils().formatCurrency(widget.data?.totalAmount.toString())}₮',
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
                width: 5,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
