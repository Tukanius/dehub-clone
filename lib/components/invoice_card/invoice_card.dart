import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
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
  final Invoice data;
  final int index;
  final bool startAnimation;
  const InvoiceCard({
    super.key,
    required this.startAnimation,
    required this.index,
    this.onClick,
    required this.data,
  });

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  User user = User();
  General general = General();
  bool value = false;

  invoiceStatus() {
    final result = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invoiceStatus);
    return result;
  }

  paymentStatus() {
    final result = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == widget.data.paymentStatus);
    return result;
  }

  textColor() {
    switch (widget.data.paymentStatus) {
      case "PENDING":
        return yellow;
      case "DIVIDED":
        return Colors.blue;
      case "CLOSED":
        return green;
      default:
    }
  }

  overdueStatus() {
    final res = general.overdueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    general =
        Provider.of<GeneralProvider>(context, listen: false).invoiceGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        user.currentBusiness?.type == "SUPPLIER" &&
                                    widget.data.type == "SALES" ||
                                user.currentBusiness?.type == "BUYER" &&
                                    widget.data.type == "PURCHASE"
                            ? '${widget.data.receiverBusiness?.logo}'
                            : '${widget.data.senderBusiness?.logo}',
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: grey,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              user.currentBusiness?.type == "SUPPLIER" &&
                                          widget.data.type == "SALES" ||
                                      user.currentBusiness?.type == "BUYER" &&
                                          widget.data.type == "PURCHASE"
                                  ? '${widget.data.receiverBusiness?.profileName}'
                                  : '${widget.data.senderBusiness?.profileName}',
                              style: const TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                              style: const TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
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
                          Text(
                            DateFormat("yyyy-MM-dd")
                                .format(widget.data.createdAt!),
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              color: textColor().withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: grey3.withOpacity(0.3),
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
                      const SizedBox(
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
                              const Text(
                                'Баталсан: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                              Text(
                                '${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff555555),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              widget.data.paymentDate != null
                                  ? 'Төлөх: ${DateFormat('yyyy-MM-dd').format(widget.data.paymentDate!)}'
                                  : 'Төлөх: -',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff555555),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                style: const TextStyle(
                                  color: grey2,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                ),
                                children: [
                                  const TextSpan(text: 'Хугацаа хэтрэлт: '),
                                  TextSpan(
                                    text: '${overdueStatus().name}',
                                    style: TextStyle(
                                      color: Color(int.parse(
                                              overdueStatus()
                                                  .color
                                                  .substring(1, 7),
                                              radix: 16) +
                                          0xff000000),
                                    ),
                                  ),
                                ],
                              ),
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
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/inv.svg',
                                colorFilter: const ColorFilter.mode(
                                    invoiceColor, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.data.refCode}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Төлсөн:',
                                style: TextStyle(
                                  color: Color(0xff555555),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${Utils().formatCurrency(widget.data.paidAmount.toString())} ₮',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: grey2,
                                ),
                              )
                            ],
                          ),
                        ],
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
