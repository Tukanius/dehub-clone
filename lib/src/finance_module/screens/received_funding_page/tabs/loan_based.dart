import 'package:dehub/api/finance_api.dart';
import 'package:dehub/src/finance_module/components/avaible_funding_card/received_funding_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/account_detail_page/account_detail_page.dart';
import 'package:dehub/src/finance_module/screens/payment_received_funds/payment_received_funds.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class LoanBased extends StatefulWidget {
  const LoanBased({super.key});

  @override
  State<LoanBased> createState() => _LoanBasedState();
}

class _LoanBasedState extends State<LoanBased> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  Result finance = Result(count: 0, rows: []);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(financeType: 'LBF');
    finance = await FinanceApi().completedList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
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
            refreshController: refreshController,
            onLoading: finance.rows!.length == finance.count ? null : onLoading,
            onRefresh: onRefresh,
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
                                source.productType('lbf');
                                Navigator.of(context).pushNamed(
                                  AccountDetailPage.routeName,
                                  arguments: AccountDetailPageArguments(
                                      id: data.lbfRequestId),
                                );
                              },
                              paymentClick: () {
                                Navigator.of(context).pushNamed(
                                  PaymentReceivedFunds.routeName,
                                  arguments: PaymentReceivedFundsArguments(
                                      id: data.lbfRequestId),
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
