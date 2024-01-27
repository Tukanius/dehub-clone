import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RepaymentHistoryCard extends StatefulWidget {
  final Finance data;
  const RepaymentHistoryCard({
    super.key,
    required this.data,
  });

  @override
  State<RepaymentHistoryCard> createState() => _RepaymentHistoryCardState();
}

class _RepaymentHistoryCardState extends State<RepaymentHistoryCard> {
  var style = const TextStyle(
    color: grey2,
    fontSize: 12,
  );
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.data.repaymentRefCode}',
                style: TextStyle(
                  color: source.currentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.data.paymentMethod}',
                style: const TextStyle(fontWeight: FontWeight.w600),
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
                  const Text(
                    'Төлсөн: ',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(widget.data.createdAt!),
                    style: style,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Дүн: ',
                    style: style,
                  ),
                  Text(
                    '${Utils().formatCurrency(widget.data.trxAmount.toString())}₮',
                    style: const TextStyle(
                      color: green,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: depBrown,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    children: [
                      TextSpan(text: 'Гүйлгээний утга: ', style: style),
                      TextSpan(text: '\n${widget.data.description}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Данс: ',
                    style: style,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: grey2,
                    backgroundImage: NetworkImage(
                      '${widget.data.creditAcc?.icon}',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget.data.creditAcc?.number}',
                    style: style,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
