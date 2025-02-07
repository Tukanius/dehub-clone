import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DeliveryCard extends StatefulWidget {
  final bool? isDeliveried;
  final int index;
  final Order data;
  final bool startAnimation;
  final Function()? refCodeClick;
  final Function()? startClick;
  final Function()? onClick;
  const DeliveryCard({
    super.key,
    required this.startAnimation,
    required this.index,
    this.refCodeClick,
    this.onClick,
    this.startClick,
    this.isDeliveried,
    required this.data,
  });

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  General general = General();
  User user = User();

  status(String? status) {
    final result = general.deliveryNoteStatus
        ?.firstWhere((element) => element.code == status);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).orderGeneral;
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: grey,
                          image: DecorationImage(
                            image: NetworkImage(
                              user.currentBusiness?.type == "SUPPLIER"
                                  ? "${widget.data.receiverBusiness?.logo}"
                                  : "${widget.data.business?.logo}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      user.currentBusiness?.type == "SUPPLIER"
                          ? Expanded(
                              child: Text(
                                '${widget.data.receiverBusiness?.profileName}',
                                style: const TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                '${widget.data.business?.profileName}',
                                style: const TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: widget.refCodeClick,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    color: transparent,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/order_note.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.data.refCode}',
                          style: const TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Захиалга: ',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/inv.svg',
                        colorFilter:
                            const ColorFilter.mode(darkGreen, BlendMode.srcIn),
                      ),
                      Text(
                        ' ${widget.data.order?.purchaseCode}',
                        style: const TextStyle(
                          color: orderColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Нийт дүн:',
                        style: TextStyle(
                          color: depBrown,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                        style: const TextStyle(
                          color: orderColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Хүргэлт: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      status(widget.data.deliveryNoteStatus.toString())
                          .name
                          .toString(),
                      style: TextStyle(
                        color: Color(int.parse(
                                status(widget.data.deliveryNoteStatus
                                        .toString())
                                    .color
                                    .substring(1, 7),
                                radix: 16) +
                            0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Хүргэх:',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd").format(
                          DateTime.parse(widget.data.deliveryDate.toString())),
                      style: const TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.isDeliveried == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Эхэлсэн:  ',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                            ),
                          ),
                          widget.data.startDate == null
                              ? const Text(
                                  '-',
                                  style: TextStyle(
                                    color: buttonColor,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  DateFormat('yyyy-MM-dd HH:mm').format(
                                      DateTime.parse(widget.data.startDate!)),
                                  style: const TextStyle(
                                    color: buttonColor,
                                    fontSize: 12,
                                  ),
                                ),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.data.deliveryNoteStatus == "LOADED" &&
                                    user.currentBusiness?.type == "SUPPLIER" ||
                                widget.data.deliveryNoteStatus == "DELIVERING"
                            ? widget.startClick
                            : () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widget.data.deliveryNoteStatus == "LOADED" &&
                                        user.currentBusiness?.type ==
                                            "SUPPLIER" ||
                                    widget.data.deliveryNoteStatus ==
                                        "DELIVERING"
                                ? orderColor
                                : orderColor.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              widget.data.deliveryNoteStatus == "DELIVERING" ||
                                      user.currentBusiness?.type == "BUYER"
                                  ? SvgPicture.asset(
                                      'assets/svg/check_underline.svg',
                                      colorFilter: const ColorFilter.mode(
                                          white, BlendMode.srcIn),
                                    )
                                  : SvgPicture.asset('assets/svg/bx_timer.svg'),
                              const SizedBox(
                                width: 5,
                              ),
                              user.currentBusiness?.type == "SUPPLIER"
                                  ? widget.data.deliveryNoteStatus ==
                                          "DELIVERING"
                                      ? const Text(
                                          'Хүрсэн',
                                          style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : const Text(
                                          'Эхлэх',
                                          style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                  : const Text(
                                      'Хүлээн авах',
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
                        'Эхэлсэн: ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(widget.data.startDate!))}',
                        style: const TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Дууссан: ${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.deliveredDate!)}',
                        style: const TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            if (widget.isDeliveried == true &&
                widget.data.amountToPay != 0 &&
                user.currentBusiness?.type == "BUYER")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.startClick,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: orderColor,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.payment_rounded,
                            color: white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Төлбөр төлөх',
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
              ),
          ],
        ),
      ),
    );
  }
}
