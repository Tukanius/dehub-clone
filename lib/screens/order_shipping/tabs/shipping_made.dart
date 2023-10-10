import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/order_shipment/order_shipment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:after_layout/after_layout.dart';

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

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(pullSheetStatus: 'CONFIRMED');
    var res = await OrderApi()
        .pullSheet(ResultArguments(filter: filter, offset: offset));
    setState(() {
      pullSheet = res;
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
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
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
                  pullSheet.rows?.length != 0
                      ? Column(
                          children: pullSheet.rows!
                              .map(
                                (data) => ShippingCard(
                                  startAnimation: startAnimation,
                                  index: pullSheet.rows!.indexOf(data),
                                  data: data,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      OrderShipment.routeName,
                                      arguments:
                                          OrderShipmentArguments(data: data),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        )
                      : NotFound(
                          module: "ORDER",
                          labelText: "Хоосон байна",
                        )
                ],
              ),
            ),
          );
  }
}
