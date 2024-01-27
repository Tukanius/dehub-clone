import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/components/compromise_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class CompromisesTab extends StatefulWidget {
  final String id;
  const CompromisesTab({
    super.key,
    required this.id,
  });

  @override
  State<CompromisesTab> createState() => _CompromisesTabState();
}

class _CompromisesTabState extends State<CompromisesTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result compromise = Result(rows: [], count: 0);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(repaymentId: widget.id);
    compromise = await FinanceApi().compromiseList(
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
            child: compromise.rows!.isNotEmpty
                ? Column(
                    children: compromise.rows!
                        .map((data) => CompromiseCard(data: data))
                        .toList(),
                  )
                : const NotFound(
                    module: "FINANCE",
                    labelText: 'Хоосон байна',
                  ),
          );
  }
}
