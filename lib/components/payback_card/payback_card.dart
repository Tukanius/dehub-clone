import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/finance_module/screens/payment_page/payment_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RePaymentCard extends StatefulWidget {
  final Function()? onClick;
  final Finance data;
  final bool repayment;
  const RePaymentCard({
    super.key,
    required this.repayment,
    required this.data,
    this.onClick,
  });

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
                  style: const TextStyle(
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(
                                repaymentStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.3),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text(
                    '${repaymentStatus().name}',
                    style: TextStyle(
                      color: Color(int.parse(
                              repaymentStatus().color.substring(1, 7),
                              radix: 16) +
                          0xff000000),
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Төлбөрийн үлдэгдэл: ',
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${Utils().formatCurrency(widget.data.amountToPay.toString()) + symbol()}',
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
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
                  flex: 3,
                  child: Text(
                    'Эргэн төлөх огноо: ${DateFormat('yyyy-MM-dd').format(widget.data.repaymentDate!)} ',
                    style: const TextStyle(
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
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                      ),
                      children: [
                        const TextSpan(
                          text: 'Хугацаа: ',
                          style: TextStyle(color: depBrown),
                        ),
                        TextSpan(
                          text: '${overdueStatus().name}',
                          style: TextStyle(
                            color: Color(int.parse(
                                    overdueStatus().color.substring(1, 7),
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
            if (widget.repayment == false)
              const SizedBox(
                height: 5,
              ),
            if (widget.repayment == false)
              Align(
                alignment: Alignment.centerRight,
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: source.currentColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        FinancePayment.routeName,
                        arguments: FinancePaymentArguments(id: widget.data.id!),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Төлөх',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  overdueStatus() {
    final res = general.repaymentOverDueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  repaymentStatus() {
    final res = general.repaymentPaymentStatus!
        .firstWhere((element) => element.code == widget.data.paymentStatus);
    return res;
  }
}
