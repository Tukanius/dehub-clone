import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cbd_payment.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cod_payment.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliveryMade extends StatefulWidget {
  const DeliveryMade({super.key});

  @override
  State<DeliveryMade> createState() => _DeliveryMadeState();
}

class _DeliveryMadeState extends State<DeliveryMade> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result pullSheet = Result(count: 0, rows: []);
  Timer? timer;
  bool isSubmit = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool startAnimation = false;

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit, '');
  }

  list(page, limit, query) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(deliveryNoteStatus: "DELIVERED");
    var res = await OrderApi()
        .deliveryNoteList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      pullSheet = res;
      isLoading = false;
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    Timer(Duration(milliseconds: 300), () {
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
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    setState(() {
      startAnimation = false;
    });
    refreshController.refreshCompleted();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(color: orderColor),
          )
        : Column(
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
              Expanded(
                child: SmartRefresher(
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
                      } else if (mode == LoadStatus.noMore) {
                        body = const Text('Мэдээлэл алга байна');
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
                    child: isSubmit == true
                        ? Center(
                            child: CircularProgressIndicator(color: orderColor),
                          )
                        : pullSheet.rows?.length != 0
                            ? Column(
                                children: pullSheet.rows!
                                    .map((data) => DeliveryCard(
                                          startAnimation: startAnimation,
                                          index: pullSheet.rows!.indexOf(data),
                                          isDeliveried: true,
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                              DeliveryPage.routeName,
                                              arguments: DeliveryPageArguments(
                                                  data: data),
                                            );
                                          },
                                          refCodeClick: () {
                                            Navigator.of(context).pushNamed(
                                              ProductGive.routeName,
                                              arguments: ProductGiveArguments(
                                                  data: data),
                                            );
                                          },
                                          startClick: () {
                                            if (data.paymentTerm?.configType ==
                                                "CBD") {
                                              Navigator.of(context).pushNamed(
                                                  OrderCbdPayment.routeName);
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                OrderCodPayment.routeName,
                                                arguments:
                                                    OrderCodPaymentArguments(
                                                  lines: data.order.lines,
                                                  id: data.order.invoiceId,
                                                ),
                                              );
                                            }
                                          },
                                          data: data,
                                        ))
                                    .toList(),
                              )
                            : NotFound(
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
