import 'dart:async';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/components/inventory_supplier_card/inventory_supplier_card.dart';
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
    Future.delayed(const Duration(milliseconds: 100), () {
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
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String query) {
    if (timer != null) timer?.cancel();
    Timer(const Duration(milliseconds: 500), () {
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
        isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: productColor,
                ),
              )
            : Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading: suppliers.rows!.length == suppliers.count
                      ? null
                      : _onLoading,
                  onRefresh: _onRefresh,
                  color: productColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        suppliers.rows!.isNotEmpty
                            ? Column(
                                children: suppliers.rows!
                                    .map(
                                      (data) => InventorySupplierCard(
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            SupplierProductList.routeName,
                                            arguments:
                                                SupplierProductListArguments(
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
                            : const NotFound(
                                module: "INVENTORY",
                                labelText: 'Хоосон байна',
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
