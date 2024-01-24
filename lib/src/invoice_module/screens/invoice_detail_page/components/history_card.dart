import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatefulWidget {
  final Invoice data;
  final int index;
  final bool startAnimation;
  const HistoryCard({
    super.key,
    required this.index,
    required this.startAnimation,
    required this.data,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (widget.index * 200)),
      curve: Curves.ease,
      transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
      color: white,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${widget.data.paymentRefCode}',
                style: const TextStyle(
                  color: invoiceColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  '${Utils().formatCurrency(widget.data.trxAmount.toString())}₮',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Төлсөн: ${widget.data.debitAcc?.number}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Хүлээн авсан: ${widget.data.debitAcc?.number}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
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
            'Төлбөрийн хэрэгсэл: ${widget.data.paymentMethod}',
            style: const TextStyle(
              color: grey2,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Гүйлгээний огноо: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.data.createdAt!)}',
            style: const TextStyle(
              color: grey2,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
