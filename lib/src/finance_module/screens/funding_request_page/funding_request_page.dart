import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/avaible_funding_card/requested_funding_card.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/funding_request_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FundingRequestPage extends StatefulWidget {
  static const routeName = '/FundingRequestPage';
  const FundingRequestPage({Key? key}) : super(key: key);

  @override
  State<FundingRequestPage> createState() => _FundingRequestPageState();
}

class _FundingRequestPageState extends State<FundingRequestPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  Result finance = Result(count: 0, rows: []);

  list(page, limit, String query) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: 'SUPPLIER', query: query);
    finance = await FinanceApi()
        .requestList(ResultArguments(filter: filter, offset: offset));
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        leading: CustomBackButton(color: financingColor),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade200,
            ),
            width: 35,
          ),
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: financingColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: DashboardCard(
                      boxColor: financingColor,
                      padding: 8,
                      labelText: 'Санхүүжилт хүсэлт',
                      svgColor: white,
                      svg: 'assets/svg/sanhuujiltS.svg'),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Санхүүжих хүсэлт',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: refreshController,
                    header: WaterDropHeader(
                      waterDropColor: financingColor,
                      refresh: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: financingColor,
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
            ),
    );
  }
}
