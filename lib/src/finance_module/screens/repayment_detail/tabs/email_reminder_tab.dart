import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/components/reminder_history_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/result.dart';

class EmailReminderTab extends StatefulWidget {
  final String id;
  const EmailReminderTab({
    super.key,
    required this.id,
  });

  @override
  State<EmailReminderTab> createState() => _EmailReminderTabState();
}

class _EmailReminderTabState extends State<EmailReminderTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result history = Result(rows: [], count: 0);
  bool isLoading = true;
  bool startAnimation = false;

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(repaymentId: widget.id, isEmail: true);
    history = await FinanceApi().reminderHistory(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
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
                          (data) => ReminderHistoryCard(
                            startAnimation: startAnimation,
                            data: data,
                            index: history.rows!.indexOf(data),
                          ),
                        )
                        .toList(),
                  )
                : const NotFound(
                    module: "FINANCE",
                    labelText: 'Хоосон байна',
                  ),
          );
  }
}