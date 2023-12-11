import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RePaymentCard extends StatefulWidget {
  final Function()? onClick;
  final Finance data;
  const RePaymentCard({
    Key? key,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<RePaymentCard> createState() => RePaymentCardState();
}

class RePaymentCardState extends State<RePaymentCard> {
  General general = General();

  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.payerAcc?.currency)
        .symbol;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).financeGeneral;
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${widget.data.refCode}',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: source.currentColor),
                    color: source.currentColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/note.svg',
                    colorFilter:
                        ColorFilter.mode(source.currentColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: repaymentStatusColor(true),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text(
                    '${repaymentStatus()}',
                    style: TextStyle(
                      color: repaymentStatusColor(false),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  '${widget.data.payerBusiness?.profileName}',
                  style: TextStyle(
                    color: source.currentColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Төлбөрийн үлдэгдэл: ',
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${Utils().formatCurrency(widget.data.amountToPay.toString()) + symbol()}',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
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
                Expanded(
                  flex: 3,
                  child: Text(
                    'Эргэн төлөх огноо: ${DateFormat('yyyy-MM-dd').format(widget.data.repaymentDate!)} ',
                    style: TextStyle(
                      color: depBrown,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                      ),
                      children: [
                        TextSpan(
                          text: 'Хугацаа: ',
                          style: TextStyle(color: depBrown),
                        ),
                        TextSpan(
                          text: '${overdueStatus()}',
                          style: TextStyle(color: overdueStatusColor()),
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

  overdueStatus() {
    final res = general.repaymentOverDueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus)
        .name;
    return res;
  }

  repaymentStatus() {
    final res = general.repaymentStatus!
        .firstWhere((element) => element.code == widget.data.repaymentStatus)
        .name;
    return res;
  }

  repaymentStatusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.repaymentStatus) {
        case "CREATED":
          return Color(0xffFF9900);
        case "APPROVED":
          return Color(0xff4169E1);
        case "RECOURSED":
          return Color(0xffFF540D);
        case "CLOSED":
          return Color(0xff25B475);
        default:
      }
    } else {
      switch (widget.data.repaymentStatus) {
        case "CREATED":
          return Color(0xffFF9900).withOpacity(0.2);
        case "APPROVED":
          return Color(0xff4169E1).withOpacity(0.2);
        case "RECOURSED":
          return Color(0xffFF540D).withOpacity(0.2);
        case "CLOSED":
          return Color(0xff25B475).withOpacity(0.2);
        default:
      }
    }
  }

  overdueStatusColor() {
    switch (widget.data.overdueStatus) {
      case "NORMAL":
        return Color(0xff25B475);
      case "ONE_TO_THREE":
        return Color(0xffFF9900);
      case "FOUR_THIRTY":
        return Color(0xffFF76A1);
      case "THIRTY_ONE_SIXTY":
        return Color(0xffFF540D);
      case "SIXTY_ONE_NINETY":
        return Color(0xffEB0404);
      case "OVER_NINETY":
        return Color(0xff890E34);
      default:
    }
  }
}
