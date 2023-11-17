import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

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
                          ? NotFound(
                              module: "INVOICE",
                              labelText: "Хоосон байна!",
                            )
                          : Column(
                              children: [
                                Column(
                                  children: inventory.rows!
                                      .map(
                                        (data) => AddProductCard(
                                          readOnly: false,
                                          onClick: () {
                                            if (data.quantity != null &&
                                                data.quantity > 0) {
                                              data.totalAmount =
                                                  data.quantity * data.price;
                                              widget.goodsListenController
                                                  .goodsInvoiceChange(data);
                                              Navigator.of(context).pop();
                                            } else {
                                              data.quantity = 1;
                                              data.totalAmount =
                                                  data.quantity * data.price;
                                              widget.goodsListenController
                                                  .goodsInvoiceChange(data);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          data: data,
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
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
