import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/src/order_module/components/sales_order_card/sales_order_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/order_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceivedTab extends StatefulWidget {
  const ReceivedTab({
    super.key,
  });

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
  Map<DateTime, List<Order>> groupedItems = {};
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
        page = 1;
        groupedItems = {};
      });
      await list(page, limit);
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<OrderProvider>(context, listen: false).clearData();
    await list(page, limit);
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
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupedItems = {};
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
        type: user.currentBusiness?.type == "SUPPLIER" ? "PURCHASE" : "SALES",
        excel: false);
    var res = await OrderApi()
        .orderList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      order = res;
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
    await groupMaker();
  }

  groupMaker() {
    List<Order> group = [];
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
      group.add(
        Order(
          header: key,
          values: value,
        ),
      );
    });
    groupedList = group;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Column(
      children: [
        const SearchButton(
          color: orderColor,
          textColor: orderColor,
        ),
        isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: orderColor,
                ),
              )
            : Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  color: orderColor,
                  child: groupedList.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: groupedList
                                    .map(
                                      (data) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.ease,
                                            transform:
                                                Matrix4.translationValues(
                                                    startAnimation
                                                        ? 0
                                                        : -MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                    0,
                                                    0),
                                            duration: Duration(
                                              milliseconds: 300 +
                                                  (groupedList.indexOf(data) *
                                                      300),
                                            ),
                                            margin: const EdgeInsets.only(
                                                left: 15, bottom: 10, top: 10),
                                            child: Text(
                                              DateFormat("yyyy-MM-dd")
                                                  .format(data.header!),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: grey2,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: data.values!
                                                .map(
                                                  (item) => SalesOrderCard(
                                                    index: order.rows!
                                                        .indexOf(item),
                                                    startAnimation:
                                                        startAnimation,
                                                    onClick: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        ReceivedOrderDetail
                                                            .routeName,
                                                        arguments:
                                                            ReceivedOrderDetailArguments(
                                                          listenController:
                                                              listenController,
                                                          id: item.id!,
                                                        ),
                                                      );
                                                    },
                                                    data: item,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          ),
                        )
                      : const NotFound(
                          module: "ORDER",
                          labelText: "Захиалга олдсонгүй",
                        ),
                ),
              ),
      ],
    );
  }
}
