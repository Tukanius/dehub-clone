import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/invoice.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ClosedInvoiceCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const ClosedInvoiceCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<ClosedInvoiceCard> createState() => _ClosedInvoiceCardState();
}

class _ClosedInvoiceCardState extends State<ClosedInvoiceCard> {
  User user = User();
  General general = General();

  invoiceStatus() {
    final result = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invoiceStatus);
    return result;
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                            child: Text(
                              "Үүссэн: ${DateFormat("yyyy-MM-dd").format(widget.data.createdAt!)}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: grey2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              'Баталсан: ${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff555555),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Төлөх: ${DateFormat("yyyy-MM-dd").format(widget.data.paymentDate!)}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: grey2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              'Төлсөн:  ${DateFormat("yyyy-MM-dd").format(widget.data.paidDate ?? DateTime.now())}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff555555),
                              ),
                            ),
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
