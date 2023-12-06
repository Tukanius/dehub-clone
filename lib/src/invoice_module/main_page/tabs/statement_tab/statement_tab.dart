import 'dart:async';

import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_statement_card/invoice_statement_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/invoice_module/screens/statement_detail/statement_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatementTab extends StatefulWidget {
  const StatementTab({super.key});

  @override
  State<StatementTab> createState() => _StatementTabState();
}

class _StatementTabState extends State<StatementTab> with AfterLayoutMixin {
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
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
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
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    timer = Timer(Duration(milliseconds: 500), () {
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
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            header: WaterDropHeader(
              waterDropColor: invoiceColor,
              refresh: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: invoiceColor,
                ),
              ),
            ),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                } else {
                  body = const Text("Мэдээлэл алга байна");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: SingleChildScrollView(
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: invoiceColor,
                      ),
                    )
                  : invoice.rows?.length != 0
                      ? Column(
                          children: invoice.rows!
                              .map(
                                (data) => InvoiceStatementCard(
                                  data: data,
                                  index: invoice.rows!.indexOf(data),
                                  startAnimation: startAnimation,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      StatementDetail.routeName,
                                      arguments:
                                          StatementDetailArguments(data: data),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        )
                      : NotFound(
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
