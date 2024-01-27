import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/components/repayment_history_card.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class PaymentHistoryTab extends StatefulWidget {
  final String id;
  const PaymentHistoryTab({
    super.key,
    required this.id,
  });

  @override
  State<PaymentHistoryTab> createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<PaymentHistoryTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result history = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(repaymentId: widget.id);
    history = await FinanceApi().repaymentHistory(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: source.currentColor,
            ),
          )
        : SingleChildScrollView(
            child: history.rows!.isNotEmpty
                ? Column(
                    children: history.rows!
                        .map(
                          (data) => RepaymentHistoryCard(
                            data: data,
                          ),
                        )
                        .toList())
                : const NotFound(
                    module: 'FINANCE',
                    labelText: 'Хоосон байна',
                  ),
          );
  }
}
