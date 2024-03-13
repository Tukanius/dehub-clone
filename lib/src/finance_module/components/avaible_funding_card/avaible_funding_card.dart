import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AvaibleFundingCard extends StatefulWidget {
  final Function()? onClick;
  final Finance data;
  const AvaibleFundingCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<AvaibleFundingCard> createState() => _AvaibleFundingCardState();
}

class _AvaibleFundingCardState extends State<AvaibleFundingCard> {
  User user = User();
  General general = General();

  invoiceStatus() {
    final res = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invoiceStatus);
    return res.name;
  }

  overDueStatus() {
    final res = general.invoiceOverdueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    user.currentBusiness?.type == "SUPPLIER" &&
                            widget.data.type == "SALES"
                        ? '${widget.data.receiverBusiness?.profileName}'
                        : "${widget.data.senderBusiness?.profileName}",
                    style: const TextStyle(
                        color: dark, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: source.currentColor),
                    color: source.currentColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/sanhuujiltS.svg',
                    colorFilter:
                        ColorFilter.mode(source.currentColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: statusColor(true),
                  ),
                  child: Text(
                    '${invoiceStatus()}',
                    style: TextStyle(
                        color: statusColor(false),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                    style: const TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
                )
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
                      'Баталсан: ',
                      style: TextStyle(
                        color: Color(0xff555555),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd HH:mm")
                          .format(widget.data.confirmedDate!),
                      style: const TextStyle(
                        color: Color(0xff555555),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/inv.svg',
                      colorFilter:
                          const ColorFilter.mode(buttonColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${widget.data.refCode}',
                      style: const TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлөх: ${DateFormat("yyyy-MM-dd").format(widget.data.paymentDate!)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff555555),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Хугацаа: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff555555),
                      ),
                    ),
                    Text(
                      '${overDueStatus().name}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          int.parse(overDueStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  statusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.invoiceStatus) {
        case "DRAFT":
          return grey;
        case "SENT":
          return Colors.indigo;
        case "CONFIRMED":
          return Colors.lightBlue;
        case "REJECTED":
          return red;
        case "RETURNED":
          return pink;
        case "CANCELED":
          return pink;
        case "CLOSED":
          return green;
        default:
      }
    } else {
      switch (widget.data.invoiceStatus) {
        case "DRAFT":
          return grey.withOpacity(0.2);
        case "SENT":
          return Colors.indigo.withOpacity(0.2);
        case "CONFIRMED":
          return Colors.lightBlue.withOpacity(0.2);
        case "REJECTED":
          return red.withOpacity(0.2);
        case "RETURNED":
          return pink.withOpacity(0.2);
        case "CANCELED":
          return pink.withOpacity(0.2);
        case "CLOSED":
          return green.withOpacity(0.2);
        default:
      }
    }
  }
}
