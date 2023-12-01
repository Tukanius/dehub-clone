import 'dart:async';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/invoice.dart';

import 'package:dehub/models/result.dart';
import 'package:dehub/providers/checkout-provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Bagtsaar extends StatefulWidget {
  final String businessId;
  final bool isPackage;
  static const routeName = '/bagtsaar';
  Bagtsaar({
    required this.isPackage,
    required this.businessId,
    Key? key,
  }) : super(key: key);

  @override
  State<Bagtsaar> createState() => _BagtsaarState();
}

class _BagtsaarState extends State<Bagtsaar> with AfterLayoutMixin {
  bool isLoading = true;
  Result inventory = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  Timer? timer;
  bool isSubmit = false;
  String query = "";
  List<Invoice> packageProduct = [];
  ListenController listenController = ListenController();
  RefreshController refreshController = RefreshController();
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

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, "");
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000), () async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit, "");
      refreshController.refreshCompleted();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    listenController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        packageProduct = packageProduct;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchButton(
          borderColor: grey,
          textColor: invoiceColor,
          onChange: (_query) {
            onChange(_query);
          },
          color: invoiceColor,
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                )
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  header: WaterDropHeader(
                    waterDropColor: invoiceColor,
                    refresh: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: invoiceColor,
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
                    child: isSubmit == false
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
                                          (data) => InvoiceProductCard(
                                            isPackage: widget.isPackage,
                                            package: packageProduct,
                                            listenController: listenController,
                                            readOnly: false,
                                            onClick: () {
                                              FocusScope.of(context).unfocus();
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
                  ),
                ),
        ),
        packageProduct.isNotEmpty && widget.isPackage == true
            ? Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: CustomButton(
                  onClick: () {
                    for (var i = 0; i < packageProduct.length; i++) {
                      Provider.of<CheckOutProvider>(context, listen: false)
                          .addCart(
                              packageProduct[i], packageProduct[i].quantity!);
                    }
                    Navigator.of(context).pop();
                  },
                  labelText:
                      "${packageProduct.fold(0, (previousValue, element) => previousValue + element.quantity!)} бараа = ${Utils().formatCurrency(packageProduct.fold(0.0, (previousValue, element) => previousValue + (element.quantity!.toDouble() * element.price!)).toString())} ₮",
                  labelColor: invoiceColor,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
