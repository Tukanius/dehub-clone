import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/sales_order_card/sales_order_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ReceivedTab extends StatefulWidget {
  const ReceivedTab({super.key});

  @override
  State<ReceivedTab> createState() => _ReceivedTabState();
}

class _ReceivedTabState extends State<ReceivedTab> with AfterLayoutMixin {
  Result order = Result(count: 0, rows: []);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  User user = User();
  bool startAnimation = false;
  List<Order> groupedList = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupedList = [];
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  groupMaker() {
    Map<DateTime, List<Order>> groupedItems = {};
    for (var item in order.rows!) {
      DateTime date =
          DateTime.parse(DateFormat("yyyy-MM-dd").format(item.createdAt));
      if (groupedItems.containsKey(date)) {
        groupedItems[date]!.add(item);
      } else {
        groupedItems[date] = [item];
      }
    }
    groupedItems.forEach((key, value) {
      groupedList.add(
        Order(
          header: key,
          values: value,
        ),
      );
    });
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
        type: user.currentBusiness?.type == "SUPPLIER" ? "PURCHASE" : "SALES");
    var res = await OrderApi()
        .orderList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      order = res;
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
    await groupMaker();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : Column(
            children: [
              SearchButton(
                color: orderColor,
                textColor: orderColor,
                onChange: (query) {},
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
                  child: groupedList.length != 0
                      ? SingleChildScrollView(
                          child: Column(
                            children: groupedList
                                .map(
                                  (item) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(
                                          milliseconds: 300 +
                                              (groupedList.indexOf(item) * 300),
                                        ),
                                        curve: Curves.ease,
                                        transform: Matrix4.translationValues(
                                            startAnimation
                                                ? 0
                                                : -MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            0,
                                            0),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          '${DateFormat("yyyy-MM-dd").format(item.header!)}',
                                          style: TextStyle(
                                            color: grey3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: item.values!
                                            .map(
                                              (data) => SalesOrderCard(
                                                index:
                                                    order.rows!.indexOf(data),
                                                startAnimation: startAnimation,
                                                data: data,
                                                onClick: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    ReceivedOrderDetail
                                                        .routeName,
                                                    arguments:
                                                        ReceivedOrderDetailArguments(
                                                      id: data.id!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                            .toList(),
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : NotFound(
                          module: "ORDER",
                          labelText: "Захиалга олдсонгүй",
                        ),
                ),
              ),
            ],
          );
  }
}
