import 'dart:async';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/components/inventory_supplier_card/inventory_supplier_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/product_module/screens/supplier_product/supplier_product_list.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:after_layout/after_layout.dart';

class NonContractedTab extends StatefulWidget {
  const NonContractedTab({super.key});

  @override
  State<NonContractedTab> createState() => _NonContractedTabState();
}

class _NonContractedTabState extends State<NonContractedTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  RefreshController refreshController = RefreshController();
  Result suppliers = Result(rows: [], count: 0);
  bool isLoading = true;
  bool startAnimation = false;
  Timer? timer;

  list(page, limit) async {
    Filter filter = Filter(isContracted: false);
    Offset offset = Offset(page: page, limit: limit);
    suppliers = await InventoryApi()
        .suppliers(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
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
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String query) {
    if (timer != null) timer?.cancel();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = true;
      });
      list(page, limit);
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            header: WaterDropHeader(
              waterDropColor: productColor,
              refresh: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: productColor,
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
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: productColor,
                        ),
                      )
                    : suppliers.rows?.length != 0
                        ? Column(
                            children: suppliers.rows!
                                .map(
                                  (data) => InventorySupplierCard(
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        SupplierProductList.routeName,
                                        arguments: SupplierProductListArguments(
                                          id: data.id,
                                        ),
                                      );
                                    },
                                    index: suppliers.rows!.indexOf(data),
                                    startAnimation: startAnimation,
                                    data: data,
                                  ),
                                )
                                .toList(),
                          )
                        : NotFound(
                            module: "INVENTORY",
                            labelText: 'Хоосон байна',
                          ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
