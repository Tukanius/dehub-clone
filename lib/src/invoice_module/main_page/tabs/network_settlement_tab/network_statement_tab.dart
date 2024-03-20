import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/src/invoice_module/components/invoice_statement_card/invoice_statement_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/invoice_module/screens/network_settlement_detail/network_settlement_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NetworkSettlementTab extends StatefulWidget {
  const NetworkSettlementTab({super.key});

  @override
  State<NetworkSettlementTab> createState() => _NetworkSettlementTabState();
}

class _NetworkSettlementTabState extends State<NetworkSettlementTab>
    with AfterLayoutMixin {
  User user = User();
  int page = 1;
  int limit = 10;
  Result invoice = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;
  RefreshController refreshController = RefreshController();
  Timer? timer;

  list(page, limit, String query) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(partnerId: '');
    invoice = await InvoiceApi()
        .settlement(ResultArguments(filter: filter, offset: offset));
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
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
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
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = true;
      });
      list(page, limit, query);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchButton(
          color: invoiceColor,
          onChange: (query) {
            onChange(query);
          },
        ),
        isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              )
            : Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading:
                      invoice.rows!.length == invoice.count ? null : onLoading,
                  onRefresh: onRefresh,
                  color: invoiceColor,
                  child: SingleChildScrollView(
                    child: invoice.rows!.isNotEmpty
                        ? Column(
                            children: invoice.rows!
                                .map(
                                  (data) => InvoiceStatementCard(
                                    data: data,
                                    index: invoice.rows!.indexOf(data),
                                    startAnimation: startAnimation,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        NetworkSettlementDetail.routeName,
                                        arguments:
                                            NetworkSettlementDetailArguments(
                                                data: data),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : const NotFound(
                            module: "INVOICE",
                            labelText: "Хоосон байна",
                          ),
                  ),
                ),
              ),
      ],
    );
  }
}
