import 'package:dehub/models/order.dart';
// import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderGoodsInfo extends StatefulWidget {
  final int? index;
  final Order? data;
  OrderGoodsInfo({
    this.data,
    Key? key,
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
                      child: Text(
                        '${widget.data?.nameMon} SKU ${widget.data?.skuCode} asdfa sdf asdf asdfa sdfa s',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                        ),
                      ),
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
                          'ш',
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
                            : Text(
                                '${widget.data?.quantity?.toInt()}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                      ),
                      Expanded(
                        child: Text(
                          // '${Utils().formatCurrency(widget.data?.price.toString())}₮',
                          '',
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
              Container(
                child: Text(
                  'Нийт',
                  style: TextStyle(
                    color: black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  // '${Utils().formatCurrency("${double.parse(widget.data!.price.toString()) * double.parse(widget.data!.quantity!.toString())}")}₮',
                  '',
                  style: TextStyle(
                    color: black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
