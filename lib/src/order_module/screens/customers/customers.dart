import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/order_module/components/order_customer_card/order_customer_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderCustomers extends StatefulWidget {
  static const routeName = '/OrderCustomers';
  const OrderCustomers({super.key});

  @override
  State<OrderCustomers> createState() => OrderCustomersState();
}

class OrderCustomersState extends State<OrderCustomers> with AfterLayoutMixin {
  Result order = Result(count: 0, rows: []);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  Timer? timer;
  bool isSubmit = false;
  bool startAnimation = false;

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit, '');
  }

  list(page, limit, String value) async {
    Filter filter = Filter(partnerName: value, excel: true);
    Offset offset = Offset(page: page, limit: limit);
    var res = await OrderApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      order = res;
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, query);
      setState(() {
        isSubmit = false;
      });
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: orderColor),
        title: const Text(
          'Харилцагчийн жагсаалт',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: orderColor,
            height: 1.0,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : Column(
              children: [
                SearchButton(
                  color: orderColor,
                  onChange: (query) {
                    onChange(query);
                  },
                ),
                Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading:
                        order.rows!.length == order.count ? null : _onLoading,
                    onRefresh: _onRefresh,
                    color: orderColor,
                    child: SingleChildScrollView(
                      child: isSubmit == false
                          ? order.rows!.isNotEmpty
                              ? Column(
                                  children: order.rows!
                                      .map(
                                        (data) => OrderCustomerCard(
                                          index: order.rows!.indexOf(data),
                                          startAnimation: startAnimation,
                                          data: data,
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                              NewOrder.routeName,
                                              arguments: NewOrderArguments(
                                                  id: data.id),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                )
                              : const NotFound(
                                  module: "ORDER",
                                  labelText: "Харилцагч олдсонгүй",
                                )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: orderColor,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
