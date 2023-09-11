import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryCard extends StatefulWidget {
  final bool? isDeliveried;
  final Order? data;
  final Function()? refCodeClick;
  final Function()? startClick;
  final Function()? onClick;
  const DeliveryCard({
    Key? key,
    this.refCodeClick,
    this.onClick,
    this.startClick,
    this.isDeliveried,
    this.data,
  }) : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  deliveryNoteStatus() {
    switch (widget.data?.deliveryNoteStatus) {
      case "DRAFT":
        return "Драфт";
      case "ASSIGNED":
        return "Хуваарилсан";
      case "LOADED":
        return "Хүргэхэд бэлэх";
      case "DELIVERING":
        return "Хүргэлт эхэлсэн";
      case "DELIVERED":
        return "Хүргэлт дууссан";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.data?.receiverBusiness?.profileName}',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: widget.refCodeClick,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    color: transparent,
                    child: Row(
                      children: [
                        SvgPicture.asset('images/order_note.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.data?.refCode}',
                          style: TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: darkGreen,
                          size: 12,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Захиалга: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    SvgPicture.asset(
                      'images/inv.svg',
                      color: darkGreen,
                    ),
                    Text(
                      ' ${widget.data?.salesCode}',
                      style: TextStyle(
                        color: orderColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Нийт дүн',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${Utils().formatCurrency(widget.data?.totalAmount.toString())}₮',
                      style: TextStyle(
                        color: orderColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Статус: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' ${deliveryNoteStatus()}',
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Төлбөр',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: yellow.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      child: Text(
                        'Хүлээж буй',
                        style: TextStyle(
                          color: yellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Хүргэлт: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' Хүргэхэд бэлэн',
                      style: TextStyle(
                        color: blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Хүргэх',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '2023-06-23',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.isDeliveried != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Эхэлсэн: ',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' -',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.data?.deliveryNoteStatus != "ASSIGNED"
                            ? widget.startClick
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widget.data?.deliveryNoteStatus == "ASSIGNED"
                                ? orderColor.withOpacity(0.2)
                                : orderColor,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('images/bx_timer.svg'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Эхлэх',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Эхэлсэн 2023-06-23',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Дууссан 2023-06-23',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
