import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderAdditionalLine extends StatefulWidget {
  final Order? data;
  const OrderAdditionalLine({Key? key, this.data}) : super(key: key);

  @override
  State<OrderAdditionalLine> createState() => _OrderAdditionalLineState();
}

class _OrderAdditionalLineState extends State<OrderAdditionalLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.data?.name}'),
              SizedBox(
                height: 5,
              ),
              Text(
                '${widget.data?.quantity} ш х ${widget.data?.price}',
                style: TextStyle(
                  color: Color(0xff657786),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${widget.data!.price! * widget.data!.quantity!} ₮',
                style: TextStyle(
                  color: orderColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: orderColor,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}
