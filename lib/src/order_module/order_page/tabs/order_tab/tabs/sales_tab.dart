import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/sales_order_card/sales_order_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> with AfterLayoutMixin {
  List<Order> groupedList = [];
  Result order = Result(count: 0, rows: []);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  User user = User();
  bool startAnimation = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();
  Map<DateTime, List<Order>> groupedItems = {};

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
    await list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
        type: user.currentBusiness?.type == "SUPPLIER" ? "SALES" : "PURCHASE",
        excel: true);
    order = await OrderApi()
        .orderList(ResultArguments(filter: filter, offset: offset));
    await groupMaker();
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  groupMaker() {
    List<Order> group = [];
    for (var data in order.rows!) {
      DateTime date =
          DateTime.parse(DateFormat("yyyy-MM-dd").format(data.createdAt));
      if (groupedItems.containsKey(date)) {
        groupedItems[date]?.add(data);
      } else {
        groupedItems[date] = [data];
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

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit);
    refreshController.loadComplete();
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
                                                  color: grey2),
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
                                          )
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
