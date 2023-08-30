import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Bagtsaar extends StatefulWidget {
  final ListenController goodsListenController;
  final List<Invoice> data;
  final String businessId;
  static const routeName = '/bagtsaar';
  Bagtsaar({
    required this.data,
    required this.goodsListenController,
    required this.businessId,
    Key? key,
  }) : super(key: key);

  @override
  State<Bagtsaar> createState() => _BagtsaarState();
}

class _BagtsaarState extends State<Bagtsaar> with AfterLayoutMixin {
  bool isLoading = true;
  Result inventory = Result(rows: [], count: 0);
  Result removedList = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  Timer? timer;
  bool isSubmit = false;
  String query = "";

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '${value}', businessId: widget.businessId);

    inventory = await InventoryApi()
        .listGoods(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    // removedList.rows = inventory.rows!.removeWhere(
    //   (element) =>
    //       element.unitVariantId ==
    //       widget.data.map(
    //         (e) {
    //           return e.unitVariantId;
    //         },
    //       ),
    // );
  }

  onChange(String value) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SearchButton(
                    borderColor: invoiceColor,
                    textColor: invoiceColor,
                    onChange: (_query) {
                      onChange(_query);
                    },
                    color: invoiceColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  isSubmit == false
                      ? inventory.rows?.length == 0
                          ? Column(
                              children: [
                                Lottie.asset('images/not-found.json'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Хоосон байна!",
                                  style: TextStyle(
                                    color: invoiceColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Column(
                                  children: inventory.rows!
                                      .map(
                                        (data) => AddProductCard(
                                          hasCount: false,
                                          isCheck: false,
                                          onClick: () {
                                            widget.goodsListenController
                                                .goodsInvoiceChange(data);
                                            Navigator.of(context).pop();
                                          },
                                          color: invoiceColor,
                                          data: data,
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                // Container(
                                //   padding: const EdgeInsets.symmetric(
                                //       vertical: 10, horizontal: 25),
                                //   margin: const EdgeInsets.symmetric(
                                //       horizontal: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(5),
                                //     color: black,
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       GestureDetector(
                                //         onTap: () {
                                //           Navigator.of(context).pop();
                                //         },
                                //         child: Column(
                                //           children: [
                                //             Icon(
                                //               Icons.add_box_outlined,
                                //               color: white,
                                //             ),
                                //             Text(
                                //               'Сонгосонг нэмэх',
                                //               style: TextStyle(
                                //                 fontSize: 10,
                                //                 color: white,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       Container(
                                //         height: 35,
                                //         child: VerticalDivider(
                                //           color: white,
                                //           thickness: 1,
                                //         ),
                                //       ),
                                //       Container(
                                //         child: Row(
                                //           children: [
                                //             GestureDetector(
                                //               onTap: () {},
                                //               child: Column(
                                //                 children: [
                                //                   Icon(
                                //                     Icons.card_travel,
                                //                     color: white,
                                //                   ),
                                //                   Text(
                                //                     'Ердийн үнэ',
                                //                     style: TextStyle(
                                //                       color: white,
                                //                       fontSize: 10,
                                //                     ),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               width: 40,
                                //             ),
                                //             GestureDetector(
                                //               onTap: () {},
                                //               child: Column(
                                //                 children: [
                                //                   Icon(
                                //                     Icons.card_giftcard_rounded,
                                //                     color: white,
                                //                   ),
                                //                   Text(
                                //                     'Урамшуулал',
                                //                     style: TextStyle(
                                //                       color: white,
                                //                       fontSize: 10,
                                //                     ),
                                //                   )
                                //                 ],
                                //               ),
                                //             )
                                //           ],
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // )
                              ],
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: invoiceColor,
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
