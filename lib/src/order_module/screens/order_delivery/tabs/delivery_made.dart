import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cbd_payment.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cod_payment.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
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
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    Timer(const Duration(milliseconds: 300), () {
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
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    setState(() {
      startAnimation = false;
    });
    refreshController.refreshCompleted();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(color: orderColor),
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
                    child: isSubmit == true
                        ? const Center(
                            child: CircularProgressIndicator(color: orderColor),
                          )
                        : pullSheet.rows!.isNotEmpty
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
