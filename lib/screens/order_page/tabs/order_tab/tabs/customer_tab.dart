import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/sales_order_card/sales_order_received.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({super.key});

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> with AfterLayoutMixin {
  Result order = Result(count: 0, rows: []);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "PURCHASE");
    var res = await OrderApi()
        .orderList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      order = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            header: WaterDropHeader(
              waterDropColor: invoiceColor,
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
            child: order.rows?.length != 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SearchButton(
                          color: orderColor,
                          textColor: orderColor,
                        ),
                        Column(
                          children: order.rows!
                              .map(
                                (e) => SalesOrderReceived(
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                        ReceivedOrderDetail.routeName);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Lottie.asset('images/order-not-found.json'),
                      Text('Захиалга олдсонгүй'),
                    ],
                  ),
          );
  }
}