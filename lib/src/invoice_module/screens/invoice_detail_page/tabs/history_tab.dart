import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/components/history_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryTab extends StatefulWidget {
  final String id;
  const HistoryTab({
    super.key,
    required this.id,
  });

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result history = Result(rows: [], count: 0);
  bool isLoading = true;
  bool startAnimation = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(invoiceId: widget.id);
    history = await InvoiceApi()
        .invoiceHistory(ResultArguments(filter: filter, offset: offset));
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
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: invoiceColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: invoiceColor,
            child: history.rows!.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: history.rows!
                          .map(
                            (data) => HistoryCard(
                              startAnimation: startAnimation,
                              index: history.rows!.indexOf(data),
                              data: data,
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const NotFound(
                    module: 'INVOICE',
                    labelText: 'Төлбөрийн түүх хоосон байна',
                  ),
          );
  }
}
