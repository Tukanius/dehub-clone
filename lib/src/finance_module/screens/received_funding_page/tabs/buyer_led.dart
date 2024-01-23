import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/avaible_funding_card/received_funding_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/received_funding_detail/received_funding_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class BuyerLed extends StatefulWidget {
  static const routeName = '/BuyerLed';
  const BuyerLed({super.key});

  @override
  State<BuyerLed> createState() => _BuyerLedState();
}

class _BuyerLedState extends State<BuyerLed> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  Result finance = Result(count: 0, rows: []);

  list(page, limit, String query) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: 'BUYER', query: query);
    finance = await FinanceApi().completedList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit, '');
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
        : Refresher(
            refreshController: refreshController,
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            color: source.currentColor,
            child: SingleChildScrollView(
              child: finance.rows!.isEmpty
                  ? const NotFound(
                      module: 'INVOICE',
                      labelText: "Санхүүжилт аваагүй байна",
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: finance.rows!
                          .map(
                            (data) => ReceivedFundingCard(
                              data: data,
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                  ReceivedFundingDetailPage.routeName,
                                  arguments: ReceivedFundingDetailPageArguments(
                                    id: data.id,
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
            ),
          );
  }
}
