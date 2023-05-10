import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/invoice.dart';

class InvoiceCard extends StatefulWidget {
  static const routeName = '/invoicecard';
  final Function()? onClick;
  final Invoice? data;
  const InvoiceCard({
    Key? key,
    this.onClick,
    this.data,
  }) : super(key: key);

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  invoiceStatus() {
    switch (widget.data!.invoiceStatus) {
      case "CONFIRMED":
        return "Баталсан";
      case "DRAFT":
        return "Түр Төлөв";
      case "SENT":
        return "Илгээсэн";
      case "REJECTED":
        return "Татгалзсан";
      case "RETURNED":
        return "Буцаасан";
      case "CLOSED":
        return "Хаасан";
      default:
    }
  }

  paymentStatus() {
    switch (widget.data!.paymentStatus) {
      case "PENDING":
        return "Хүлээгдэж буй";
      case "DIVIDED":
        return "Хуваасан";
      case "OVER_DUE":
        return "Хугацаа хэтэрсэн";
      case "CLOSED":
        return "Хаасан";
      case "PENDING":
        return "Хүлээгдэж буй";
      default:
    }
  }

  fillColor() {
    switch (widget.data!.paymentStatus) {
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
    switch (widget.data!.paymentStatus) {
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
    switch (widget.data!.paymentStatus) {
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

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              "${widget.data!.getPostDate()}",
              style: TextStyle(
                color: Color(0xff636E72),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: widget.onClick,
            child: Container(
              color: white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  '${widget.data!.senderBusiness!.partner!.businessNameEng}',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${widget.data!.getsentDate()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  invoiceStatus(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: invoiceColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Төлөх: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff555555),
                                      ),
                                    ),
                                    Text(
                                      '${widget.data!.getPaymentDate()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff555555),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/inv.svg',
                                      color: invoiceColor,
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
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data!.amountToPay}',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                                paymentStatus(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                                  '${widget.data!.confirmedAmount}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
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
                                widget.data!.overDueStatus == "NORMAL"
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
                            SizedBox(
                              height: 5,
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
                                  '${widget.data!.paidAmount} ₮',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: grey2,
                                  ),
                                )
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
          ),
        ],
      ),
    );
  }
}
