import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderAdditionalLine extends StatefulWidget {
  final Function()? onClick;
  final Order? data;
  const OrderAdditionalLine({
    super.key,
    this.data,
    this.onClick,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.data?.name}'),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.data?.quantity} ш х ${Utils().formatCurrency(widget.data?.price.toString()) + "₮"}',
                style: const TextStyle(
                  color: Color(0xff657786),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onClick,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  color: transparent,
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/svg/close.svg',
                    colorFilter: const ColorFilter.mode(grey2, BlendMode.srcIn),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '${Utils().formatCurrency((widget.data!.price! * widget.data!.quantity!).toString())} ₮',
                    style: const TextStyle(
                      color: orderColor,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: orderColor,
                    size: 15,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
