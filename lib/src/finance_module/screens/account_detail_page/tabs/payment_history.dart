import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  final List<Finance> data;
  final String currency;
  const PaymentHistory({
    super.key,
    required this.currency,
    required this.data,
  });

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  General general = General();

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.currency);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return SingleChildScrollView(
      child: Column(
        children: widget.data
            .map(
              (data) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${data.payerAccName}',
                            style: TextStyle(
                              color: source.currentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${data.refCode}',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Төлсөн данс: ${data.payerAccNum}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Данс: ${data.accountNum}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Эхний дүн: ${Utils().formatCurrency("${data.firstAmount}") + currency().symbol}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Эцсийн дүн: ${Utils().formatCurrency("${data.lastAmount}") + currency().symbol}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Төлсөн: ${DateFormat('yyyy-MM-dd').format(data.createdAt!)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Дүн: ${Utils().formatCurrency("${data.amount}") + currency().symbol}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
