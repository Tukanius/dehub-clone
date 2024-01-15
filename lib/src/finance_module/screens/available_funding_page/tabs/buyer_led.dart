import 'dart:async';

import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:dehub/components/avaible_funding_card/avaible_funding_card.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:after_layout/after_layout.dart';

class BuyerLed extends StatefulWidget {
  final String id;
  const BuyerLed({
    super.key,
    required this.id,
  });

  @override
  State<BuyerLed> createState() => _BuyerLedState();
}

class _BuyerLedState extends State<BuyerLed> with AfterLayoutMixin {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result finance = Result(rows: [], count: 0);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(productType: "BUYER_LED", programId: widget.id);
    var res = await FinanceApi().financeableList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      finance = res;
      isLoading = false;
    });
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    list(page, limit);
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return Refresher(
      refreshController: refreshController,
      onLoading: onLoading,
      onRefresh: onRefresh,
      color: source.currentColor,
      child: SingleChildScrollView(
        child: isLoading == true
            ? Container(
                margin: const EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(
                    color: source.currentColor,
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: finance.rows!
                        .map(
                          (data) => AvaibleFundingCard(
                            data: data,
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                AvaibleFundingDetailPage.routeName,
                                arguments: AvaibleFundingDetailPageArguments(
                                  programId: widget.id,
                                  id: data.id,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }
}
