import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/order_customer_card/order_customer_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/new_order/new_order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({Key? key}) : super(key: key);

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> with AfterLayoutMixin {
  Result order = Result(count: 0, rows: []);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Timer? timer;
  bool isSubmit = false;
  bool startAnimation = false;
  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit, '');
  }

  list(page, limit, String value) async {
    Filter filter = Filter(partnerName: '${value}');
    Offset offset = Offset(page: page, limit: limit);
    var res = await OrderApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      order = res;
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, query);
      setState(() {
        isSubmit = false;
      });
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
        : SingleChildScrollView(
            child: Column(
              children: [
                SearchButton(
                  color: orderColor,
                  onChange: (_query) {
                    onChange(_query);
                  },
                ),
                isSubmit == false
                    ? order.rows?.length != 0
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
                                        arguments:
                                            NewOrderArguments(id: data.id),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : NotFound(
                            module: "ORDER",
                            labelText: "Харилцагч олдсонгүй",
                          )
                    : Center(
                        child: CircularProgressIndicator(
                          color: orderColor,
                        ),
                      ),
              ],
            ),
          );
  }
}
