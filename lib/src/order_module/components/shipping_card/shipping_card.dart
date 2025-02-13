import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ShippingCard extends StatefulWidget {
  final Function()? onClick;
  final Order? data;
  final int index;
  final bool startAnimation;
  const ShippingCard({
    super.key,
    required this.startAnimation,
    this.onClick,
    required this.index,
    this.data,
  });

  @override
  State<ShippingCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<ShippingCard> {
  General general = General();
  status(String pullSheetStatus) {
    final result = general.pullSheetStatus
        ?.firstWhere((element) => element.code == pullSheetStatus)
        .name;
    return result;
  }

  statusColor() {
    switch (widget.data?.pullSheetStatus) {
      case "APPROVED":
        return 0xffC8C9C9;
      case "LOADING":
        return 0xffFD8E31;
      case "LOADED":
        return 0xff01C129;
      case "CONFIRMED":
        return 0xff1642F4;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).orderGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.data?.warehouse?.name}',
                    style: const TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/inv.svg',
                      colorFilter:
                          const ColorFilter.mode(darkGreen, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.data?.refCode}',
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
                      'Ачих огноо: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    widget.data?.loadingDate != null
                        ? Text(
                            DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(widget.data!.loadingDate!)),
                            style: const TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : const Text(
                            '-',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                  ],
                ),
                Text(
                  DateFormat("yyyy-MM-dd HH:mm")
                      .format(widget.data!.createdAt!),
                  style: const TextStyle(
                    color: buttonColor,
                    fontSize: 12,
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
                      'Эхэлсэн: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    widget.data?.startedDate == null
                        ? const Text(
                            '-',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data!.startedDate!),
                            style: const TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Нярав: ',
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
                      '${widget.data?.staff?.firstName}',
                      style: const TextStyle(
                        color: orderColor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Дууссан: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    widget.data?.endedDate == null
                        ? const Text(
                            '-',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data!.endedDate!),
                            style: const TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(statusColor()).withOpacity(0.2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Text(
                    '${status(widget.data!.pullSheetStatus!)}',
                    style: TextStyle(
                      color: Color(statusColor()),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
