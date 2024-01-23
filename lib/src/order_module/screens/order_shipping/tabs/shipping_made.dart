import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/order_shipment/order_shipment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
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
  Map<DateTime, List<Order>> groupItems = {};

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
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      groupItems = {};
      page = 1;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  groupMaker() {
    List<Order> group = [];
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const SearchButton(
                color: orderColor,
                textColor: orderColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  color: orderColor,
                  child: SingleChildScrollView(
                    child: groupedList.isNotEmpty
                        ? Column(
                            children: groupedList
                                .map(
                                  (data) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          DateFormat("yyyy-MM-dd")
                                              .format(data.header!),
                                          style: const TextStyle(
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
                                                index: pullSheet.rows!
                                                    .indexOf(item),
                                                data: item,
                                                onClick: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
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
                        : const NotFound(
                            module: "ORDER",
                            labelText: "Хоосон байна",
                          ),
                  ),
                ),
              ),
            ],
          );
  }
}
