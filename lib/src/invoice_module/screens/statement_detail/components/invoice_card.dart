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
      {Key? key,
      this.onClick,
      required this.data,
      required this.index,
      required this.startAnimation})
      : super(key: key);

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
        padding: const EdgeInsets.only(right: 15),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      color: invoiceColor,
                      width: 2,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: invoiceColor,
                  value: value,
                  onChanged: (value1) {
                    setState(() {
                      value = value1!;
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/inv.svg',
                                  colorFilter: ColorFilter.mode(
                                      invoiceColor, BlendMode.srcIn),
                                ),
                                Text(
                                  '  ${widget.data.refCode}',
                                  style: TextStyle(
                                    color: invoiceColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                              style: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                          Text(
                            "Төлөх огноо: ${DateFormat("yyyy-MM-dd").format(widget.data.paymentDate!)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.data.respondText}',
                            style: TextStyle(
                              fontSize: 12,
                              color: invoiceColor,
                            ),
                          ),
                          Text(
                            'Баталсан: ${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Төлсөн: ${Utils().formatCurrency(widget.data.paidAmount.toString())}₮',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
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
                                    int.parse(
                                            overdueStatus()
                                                .color
                                                .substring(1, 7),
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
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Үлдсэн хоног: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: depBrown,
                            ),
                          ),
                          Text(
                            '${widget.data.paymentDate?.difference(DateTime.now()).inDays}',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
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
