import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/program_card/program_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/available_funding_page/available_funding_page.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/result.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuyerLed extends StatefulWidget {
  const BuyerLed({super.key});

  @override
  State<BuyerLed> createState() => _BuyerLedState();
}

class _BuyerLedState extends State<BuyerLed> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result finance = Result(count: 0, rows: []);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(productType: "BUYER_LED");
    var res = await FinanceApi().programList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      finance = res;
      isLoading = false;
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    list(page, limit);
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    list(page, limit);
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
            child: CircularProgressIndicator(
              color: source.currentColor,
            ),
          )
        : Refresher(
            color: source.currentColor,
            onLoading: onLoading,
            onRefresh: onRefresh,
            refreshController: refreshController,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  finance.rows!.isNotEmpty
                      ? Column(
                          children: finance.rows!
                              .map(
                                (data) => ProgramCard(
                                  onClick: () {
                                    source.productType('BUYER_LED');
                                    Navigator.of(context).pushNamed(
                                      AvailableFundingPage.routeName,
                                      arguments: AvailableFundingPageArguments(
                                          id: data.id),
                                    );
                                  },
                                  data: data,
                                ),
                              )
                              .toList(),
                        )
                      : const NotFound(
                          module: "FINANCE",
                          labelText: 'Хоосон байна',
                        ),
                ],
              ),
            ),
          );
  }
}
