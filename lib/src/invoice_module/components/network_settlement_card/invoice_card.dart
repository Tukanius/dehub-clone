import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceCard extends StatefulWidget {
  final Function()? onClick;
  final int index;
  final bool startAnimation;
  final Invoice data;
  const InvoiceCard(
      {super.key,
      this.onClick,
      required this.data,
      required this.index,
      required this.startAnimation});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  bool value = false;
  General general = General();

  overdueStatus() {
    final res = general.overdueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 15),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/inv.svg',
                        colorFilter: const ColorFilter.mode(
                            invoiceColor, BlendMode.srcIn),
                      ),
                      Text(
                        '  ${widget.data.refCode}',
                        style: const TextStyle(
                          color: invoiceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                    style: const TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data.paidDate == null
                    ? Text(
                        DateFormat("yyyy-MM-dd HH:mm")
                            .format(widget.data.createdAt!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: grey2,
                        ),
                      )
                    : Text(
                        DateFormat("yyyy-MM-dd HH:mm")
                            .format(widget.data.paidDate!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: grey2,
                        ),
                      ),
                Text(
                  widget.data.paymentDate != null
                      ? "Төлөх огноо: ${DateFormat("yyyy-MM-dd").format(widget.data.paymentDate!)}"
                      : "Төлөх огноо: -",
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data.respondText != null
                    ? Text(
                        '${widget.data.respondText}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: invoiceColor,
                        ),
                      )
                    : const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 12,
                          color: invoiceColor,
                        ),
                      ),
                Text(
                  'Баталсан: ${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлсөн: ${Utils().formatCurrency(widget.data.paidAmount.toString())}₮',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Хугацаа: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: grey2,
                      ),
                    ),
                    Text(
                      '${overdueStatus().name}',
                      style: TextStyle(
                        color: Color(
                          int.parse(overdueStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000,
                        ),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  'Үлдсэн хоног: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: depBrown,
                  ),
                ),
                widget.data.paymentDate != null
                    ? widget.data.paidDate == null
                        ? Text(
                            '${widget.data.paymentDate?.difference(DateTime.now()).inDays}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            '${widget.data.paymentDate?.difference(widget.data.paidDate!).inDays}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                    : const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey2,
                          fontWeight: FontWeight.w600,
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
