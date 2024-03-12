import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:async';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/result.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/avaible_funding_card/avaible_funding_card.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';

class AvailableFundingPageArguments {
  String id;
  AvailableFundingPageArguments({
    required this.id,
  });
}

class AvailableFundingPage extends StatefulWidget {
  static const routeName = '/AvailableFundingPage';
  final String id;
  const AvailableFundingPage({
    super.key,
    required this.id,
  });

  @override
  State<AvailableFundingPage> createState() => _AvailableFundingPageState();
}

class _AvailableFundingPageState extends State<AvailableFundingPage>
    with AfterLayoutMixin {
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  int limit = 10;
  Result finance = Result(rows: [], count: 0);

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(financeType: source.type, programId: widget.id);
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
    await Future.delayed(const Duration(milliseconds: 1000));
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leadingWidth: 130,
        surfaceTintColor: backgroundColor,
        leading: CustomBackButton(color: source.currentColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: DashboardCard(
              boxColor: source.currentColor,
              padding: 10,
              labelText: 'Боломжит нэхэмжлэх',
              svgColor: white,
              svg: 'assets/svg/available_invoice.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Боломжит нэхэмжлэхүүд',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: isLoading == true
                ? Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: source.currentColor,
                      ),
                    ),
                  )
                : Refresher(
                    refreshController: refreshController,
                    onLoading: finance.rows!.length == finance.count
                        ? null
                        : onLoading,
                    onRefresh: onRefresh,
                    color: source.currentColor,
                    child: SingleChildScrollView(
                      child: finance.rows!.isNotEmpty
                          ? Column(
                              children: [
                                Column(
                                  children: finance.rows!
                                      .map(
                                        (data) => AvaibleFundingCard(
                                          data: data,
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                              AvaibleFundingDetailPage
                                                  .routeName,
                                              arguments:
                                                  AvaibleFundingDetailPageArguments(
                                                programId: widget.id,
                                                id: data.id,
                                              ),
                                            );
                                          },
                                        ),
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
                  ),
          ),
        ],
      ),
    );
  }
}
