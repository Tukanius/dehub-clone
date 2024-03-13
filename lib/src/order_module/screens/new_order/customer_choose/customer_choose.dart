import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/order_module/components/order_customer_card/order_customer_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderCustomerChooseArguments {
  ListenController customerListenController;
  OrderCustomerChooseArguments({
    required this.customerListenController,
  });
}

class OrderCustomerChoose extends StatefulWidget {
  final ListenController customerListenController;
  static const routeName = '/OrderCustomerChoose';
  const OrderCustomerChoose({
    super.key,
    required this.customerListenController,
  });

  @override
  State<OrderCustomerChoose> createState() => _OrderCustomerChooseState();
}

class _OrderCustomerChooseState extends State<OrderCustomerChoose>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result customer = Result(count: 0, rows: []);
  bool startAnimation = false;
  RefreshController refreshController = RefreshController();

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(categoryId: '', excel: false);
    var res = await OrderApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      customer = res;
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
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
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: orderColor),
        title: const Text(
          'Харилцагч сонгох',
          style: TextStyle(
            color: buttonColor,
            fontWeight: FontWeight.w500,
            fontSize: 17,
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
                const SearchButton(
                  color: orderColor,
                  textColor: orderColor,
                ),
                Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: customer.rows!.length == customer.count
                        ? null
                        : _onLoading,
                    onRefresh: _onRefresh,
                    color: orderColor,
                    child: SingleChildScrollView(
                      child: Column(
                        children: customer.rows!
                            .map(
                              (item) => OrderCustomerCard(
                                index: customer.rows!.indexOf(item),
                                startAnimation: startAnimation,
                                onClick: () {
                                  widget.customerListenController
                                      .customerOrderChange(item);
                                  Navigator.of(context).pop();
                                },
                                data: item,
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
