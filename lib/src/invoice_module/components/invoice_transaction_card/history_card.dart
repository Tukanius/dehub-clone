import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const HistoryCard({
    super.key,
    required this.data,
    this.onClick,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  General general = General();
  bool value = false;

  paymentMethod() {
    final res = general.paymentMethod!
        .firstWhere((element) => element.code == widget.data.paymentMethod);
    return res.name;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Гүйлгээний лавлах',
                    style: TextStyle(
                      color: invoiceColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: grey3,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat("yyyy-MM-dd HH:mm")
                        .format(widget.data.createdAt!),
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${Utils().formatCurrency(widget.data.trxAmount.toString())}₮',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 16,
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
              children: [
                Expanded(
                  child: Text(
                    '${widget.data.description}',
                    style: const TextStyle(
                      color: invoiceColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.data.actionUser?.firstName}',
                    style: const TextStyle(
                      color: grey2,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${paymentMethod()}',
              style: const TextStyle(
                color: invoiceColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
