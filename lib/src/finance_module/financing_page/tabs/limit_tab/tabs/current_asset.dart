import 'package:dehub/api/finance_api.dart';
import 'package:dehub/src/finance_module/components/limit_usage_card/limit_usage_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CurrentAssetTab extends StatefulWidget {
  const CurrentAssetTab({super.key});

  @override
  State<CurrentAssetTab> createState() => _CurrentAssetTabState();
}

class _CurrentAssetTabState extends State<CurrentAssetTab>
    with AfterLayoutMixin {
  int limit = 10;
  int page = 1;
  bool isLoading = true;
  Result limitUsage = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "CURRENT_ASSET");
    limitUsage = await FinanceApi().limitUsage(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
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
      isLoading = true;
      limit = 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
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
            child: CircularProgressIndicator(color: source.currentColor),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading:
                limitUsage.rows!.length == limitUsage.count ? null : onLoading,
            onRefresh: onRefresh,
            color: source.currentColor,
            child: SingleChildScrollView(
              child: limitUsage.rows!.isNotEmpty
                  ? Column(
                      children: [
                        Column(
                          children: limitUsage.rows!
                              .map(
                                (data) => LimitUsageCard(data: data),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : const NotFound(
                      module: "FINANCE",
                      labelText: 'Хоосон байна',
                    ),
            ),
          );
  }
}
