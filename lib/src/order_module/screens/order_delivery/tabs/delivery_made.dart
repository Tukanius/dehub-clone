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
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

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

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(color: orderColor),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SearchButton(
                  onChange: (query) {
                    onChange(query);
                  },
                  color: orderColor,
                  textColor: orderColor,
                ),
                SizedBox(
                  height: 5,
                ),
                isSubmit == true
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
                                          arguments:
                                              DeliveryPageArguments(data: data),
                                        );
                                      },
                                      refCodeClick: () {
                                        Navigator.of(context).pushNamed(
                                          ProductGive.routeName,
                                          arguments:
                                              ProductGiveArguments(data: data),
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
                                            arguments: OrderCodPaymentArguments(
                                                id: data.order.invoiceId),
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
              ],
            ),
          );
  }
}
