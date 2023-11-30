import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/order_shipment/order_shipment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class ShippingMade extends StatefulWidget {
  const ShippingMade({super.key});

  @override
  State<ShippingMade> createState() => _ShippingMadeState();
}

class _ShippingMadeState extends State<ShippingMade> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result pullSheet = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  double screenWidth = 0;
  List<Order> groupedList = [];

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(pullSheetStatus: 'CONFIRMED');
    pullSheet = await OrderApi()
        .pullSheet(ResultArguments(filter: filter, offset: offset));
    await groupMaker();
    setState(() {
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      groupedList = [];
      page = 1;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  groupMaker() {
    Map<DateTime, List<Order>> groupItems = {};
    for (var data in pullSheet.rows!) {
      DateTime date =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(data.createdAt));
      if (groupItems.containsKey(date)) {
        groupItems[date]!.add(data);
      } else {
        groupItems[date] = [data];
      }
    }
    groupItems.forEach((key, value) {
      groupedList.add(
        Order(
          header: key,
          values: value,
        ),
      );
    });
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
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
              waterDropColor: orderColor,
              refresh: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: orderColor,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SearchButton(
                    color: orderColor,
                    textColor: orderColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  groupedList.length != 0
                      ? Column(
                          children: groupedList
                              .map(
                                (data) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedContainer(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      duration: Duration(
                                        milliseconds: 300 +
                                            (groupedList.indexOf(data) * 300),
                                      ),
                                      curve: Curves.ease,
                                      transform: Matrix4.translationValues(
                                          startAnimation ? 0 : -screenWidth,
                                          0,
                                          0),
                                      child: Text(
                                        '${DateFormat("yyyy-MM-dd").format(data.header!)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: grey3,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: data.values!
                                          .map(
                                            (item) => ShippingCard(
                                              startAnimation: startAnimation,
                                              index:
                                                  pullSheet.rows!.indexOf(item),
                                              data: item,
                                              onClick: () {
                                                Navigator.of(context).pushNamed(
                                                  OrderShipment.routeName,
                                                  arguments:
                                                      OrderShipmentArguments(
                                                    data: item,
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
                        )
                      : NotFound(
                          module: "ORDER",
                          labelText: "Хоосон байна",
                        ),
                ],
              ),
            ),
          );
  }
}
