import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GoodsInfoCard extends StatefulWidget {
  final int? index;
  final Invoice? data;
  GoodsInfoCard({
    this.data,
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<GoodsInfoCard> createState() => _GoodsInfoCardState();
}

class _GoodsInfoCardState extends State<GoodsInfoCard> {
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
                      margin: EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        '${widget.index! + 1} ',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      child: Text(
                        '${widget.data?.nameMon} SKU ${widget.data?.skuCode}',
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
                        child: Text(
                          '${widget.data?.quantity?.toInt()}',
                          style: TextStyle(
                            color: black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${widget.data?.price}₮',
                          style: TextStyle(
                            color: black,
                            fontSize: 12,
                          ),
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
                  '${widget.data?.price}₮',
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
        ],
      ),
    );
  }
}
