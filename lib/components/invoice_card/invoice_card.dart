import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/invoice.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatefulWidget {
  static const routeName = '/invoicecard';
  final Function()? onClick;
  final Invoice? data;
  final int index;
  final bool startAnimation;
  const InvoiceCard({
    Key? key,
    required this.startAnimation,
    required this.index,
    this.onClick,
    this.data,
  }) : super(key: key);

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  Partner user = Partner();
  General general = General();
  bool value = false;

  invoiceStatus() {
    final result = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data?.invoiceStatus);
    return result;
  }

  paymentStatus() {
    final result = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == widget.data?.paymentStatus);
    return result;
  }

  fillColor() {
    switch (widget.data?.paymentStatus) {
      case "PENDING":
        return invoiceColor.withOpacity(0.3);
      case "DIVIDED":
        return lightYellow.withOpacity(0.5);
      case "OVER_DUE":
        return lightRed.withOpacity(0.5);
      case "CLOSED":
        return green.withOpacity(0.4);
      case "PENDING":
        return buttonColor.withOpacity(0.3);
      default:
    }
  }

  borderColor() {
    switch (widget.data?.paymentStatus) {
      case "PENDING":
        return grey3.withOpacity(0.4);
      case "DIVIDED":
        return lightYellow;
      case "OVER_DUE":
        return lightRed;
      case "CLOSED":
        return grey3.withOpacity(0.4);
      case "PENDING":
        return grey3.withOpacity(0.4);
      default:
    }
  }

  textColor() {
    switch (widget.data?.paymentStatus) {
      case "PENDING":
        return invoiceColor;
      case "DIVIDED":
        return grey3;
      case "OVER_DUE":
        return Colors.red;
      case "CLOSED":
        return green;
      case "PENDING":
        return buttonColor;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).partnerUser;
    general =
        Provider.of<GeneralProvider>(context, listen: false).invoiceGeneral;
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
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          user.user?.currentBusiness?.type == "SUPPLIER"
                              ? Expanded(
                                  child: Text(
                                    '${widget.data?.receiverBusiness?.partner?.businessName}',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Text(
                                    '${widget.data?.senderBusiness?.partner?.businessName}',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                          Expanded(
                            child: Text(
                              '${Utils().formatCurrency(widget.data!.amountToPay.toString())}₮',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
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
                            '${DateFormat("yyyy-MM-dd").format(widget.data!.createdAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              color: fillColor(),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: borderColor(),
                              ),
                            ),
                            child: Text(
                              paymentStatus().name,
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor(),
                              ),
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(int.parse(
                                        invoiceStatus().color.substring(1, 7),
                                        radix: 16) +
                                    0xff000000),
                              ),
                            ),
                            child: Text(
                              invoiceStatus().name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(int.parse(
                                        invoiceStatus().color.substring(1, 7),
                                        radix: 16) +
                                    0xff000000),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Баталсан: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                              Text(
                                '${Utils().formatCurrency(widget.data!.confirmedAmount.toString())}₮',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Төлөх: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                              widget.data?.paymentDate != null
                                  ? Text(
                                      '${DateFormat('yyyy-MM-dd').format(widget.data!.paymentDate!)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff555555),
                                      ),
                                    )
                                  : Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff555555),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Хугацаа: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                              widget.data!.overdueStatus == "NORMAL"
                                  ? Text(
                                      'Хэвийн',
                                      style: TextStyle(
                                        color: green,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      'Хугацаа хэтэрсэн',
                                      style: TextStyle(
                                        color: buttonColor,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/inv.svg',
                                colorFilter: ColorFilter.mode(
                                    invoiceColor, BlendMode.srcIn),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.data!.refCode}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Төлсөн:',
                                style: TextStyle(
                                  color: Color(0xff555555),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${Utils().formatCurrency(widget.data!.paidAmount.toString())} ₮',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: grey2,
                                ),
                              )
                            ],
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
