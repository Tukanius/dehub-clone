import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:after_layout/after_layout.dart';

class AllTab extends StatefulWidget {
  final InventoryGoods data;
  final ListenController productListenController;
  const AllTab({
    Key? key,
    required this.data,
    required this.productListenController,
  }) : super(key: key);

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> with AfterLayoutMixin {
  Result order = Result(count: 0, rows: []);
  bool isLoading = true;
  String query = '';
  int limit = 10;
  Timer? timer;
  int currentIndex = 0;

  bool isSubmit = false;
  @override
  afterFirstLayout(BuildContext context) async {
    order = await OrderApi().variantSelect("SALES", 'a', query, '', '', '');
    setState(() {
      isLoading = false;
    });
  }

  onChange(String value) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      order = await OrderApi().variantSelect("SALES", 'a', query, "", '', '');
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
                  textColor: orderColor,
                  onChange: (query) {
                    onChange(query);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                isSubmit == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: orderColor,
                        ),
                      )
                    : order.rows?.length == 0
                        ? NotFound(
                            module: "ORDER",
                            labelText: "Бараа олдсонгүй",
                          )
                        : Column(
                            children: order.rows!
                                .map(
                                  (item) => Column(
                                    children: [
                                      OrderProductCard(
                                        onClick: () {
                                          if (item.quantity > 0 ||
                                              item.quantity == null) {
                                            widget.productListenController
                                                .productOrderChange(item);
                                            Navigator.of(context).pop();
                                          } else {
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //     backgroundColor: orderColor,
                                            //     shape: StadiumBorder(),
                                            //     content: Center(
                                            //       child: Text(
                                            //           'Тоо ширхэг нэмнэ үү!'),
                                            //     ),
                                            //   ),
                                            // );
                                          }
                                        },
                                        data: item,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
  }
}
