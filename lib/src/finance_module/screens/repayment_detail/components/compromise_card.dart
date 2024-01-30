import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CompromiseCard extends StatefulWidget {
  final Finance data;
  const CompromiseCard({
    super.key,
    required this.data,
  });

  @override
  State<CompromiseCard> createState() => _CompromiseCardState();
}

class _CompromiseCardState extends State<CompromiseCard> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.data.refCode}",
            style: TextStyle(
              color: source.currentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: grey2, fontSize: 12, fontFamily: 'Montserrat'),
                    children: [
                      const TextSpan(text: 'Амласан дүн: '),
                      TextSpan(
                        text:
                            '${Utils().formatCurrency(widget.data.amount.toString())}₮',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: const TextStyle(
                        color: grey2, fontSize: 12, fontFamily: 'Montserrat'),
                    children: [
                      const TextSpan(text: 'Амласан огноо: '),
                      TextSpan(
                        text: DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(widget.data.date!)),
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
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: grey2, fontSize: 12, fontFamily: 'Montserrat'),
              children: [
                const TextSpan(text: 'Амлалт өгсөн ажилтан: '),
                TextSpan(text: "${widget.data.actionUser?.lastName} "),
                TextSpan(text: widget.data.actionUser?.firstName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
