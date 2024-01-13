import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/avaible_funding_card/requested_funding_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/funding_request_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class BuyerLed extends StatefulWidget {
  const BuyerLed({Key? key}) : super(key: key);

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
    finance = await FinanceApi().requestList(
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
    await Future.delayed(Duration(milliseconds: 1000));
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  header: WaterDropHeader(
                    waterDropColor: source.currentColor,
                    refresh: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: source.currentColor,
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
                    child: finance.rows?.length == 0
                        ? NotFound(
                            module: 'INVOICE',
                            labelText: "Хоосон байна",
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: finance.rows!
                                .map(
                                  (data) => RequestedFundingCard(
                                    data: data,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        FundingRequestDetailPage.routeName,
                                        arguments:
                                            FundingRequestDetailPageArguments(
                                          id: data.id,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                ),
              ),
            ],
          );
  }
}
