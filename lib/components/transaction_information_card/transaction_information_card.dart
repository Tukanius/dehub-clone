import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionInformationCard extends StatefulWidget {
  final Function()? onClick;
  final bool startAnimation;
  final int index;
  final Payment? data;
  const TransactionInformationCard({
    super.key,
    required this.index,
    required this.startAnimation,
    this.onClick,
    this.data,
  });

  @override
  TransactionInformationCardState createState() =>
      TransactionInformationCardState();
}

class TransactionInformationCardState
    extends State<TransactionInformationCard> {
  General general = General();

  getCurrency() {
    String? res;
    if (widget.data?.creditAccountCurrency != null) {
      res = general.currencies!
          .firstWhere(
              (element) => element.code == widget.data?.creditAccountCurrency)
          .symbol;
    } else {
      res = general.currencies!
          .firstWhere(
              (element) => element.code == widget.data?.debitAccountCurrency)
          .symbol;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).paymentGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 100)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.data?.description}',
                    style: const TextStyle(
                        color: grey2, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xff545454),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("yyyy-MM-dd HH:mm")
                      .format(widget.data!.createdAt!),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff555555),
                  ),
                ),
                Text(
                  '${Utils().formatCurrency(widget.data?.amount.toString())} ${getCurrency()}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color:
                          widget.data?.inOutType == "DEBIT" ? neonGreen : red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
