import 'dart:async';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/product_module/screens/set_price/set_price.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/set_warehouse.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/src/product_module/components/goods_card/goods_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/product_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class GoodsTab extends StatefulWidget {
  const GoodsTab({
    super.key,
  });

  @override
  State<GoodsTab> createState() => _GoodsTabState();
}

class _GoodsTabState extends State<GoodsTab> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result inventory = Result(rows: [], count: 0);
  Timer? timer;
  ListenController listenController = ListenController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool startAnimation = false;
  Result inactiveTypes = Result(rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
  }

  list(page, limit, String value) async {
    Filter filter = Filter(itemStatus: '');
    Offset offset = Offset(page: page, limit: limit);
    Result res = await InventoryApi()
        .listProduct(ResultArguments(filter: filter, offset: offset));
    setState(() {
      inventory = res;
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  onChange(String value) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      list(page, limit, value);
    });
  }

  inactive(String id, String status, String inactiveTypeId) async {
    await InventoryApi().statusChange(
      InventoryGoods(
        status: status,
        inactiveTypeId: inactiveTypeId,
      ),
      id,
    );
    listenController.changeVariable('inactive');
    showCustomDialog(
      context,
      'Амжилттай',
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    listenController.addListener(() {
      list(page, limit, '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<LoadingProvider>(context, listen: true);
    return Column(
      children: [
        SearchButton(
          onChange: (query) {
            onChange(query);
          },
          color: productColor,
          textColor: productColor,
          borderColor: productColor,
        ),
        Expanded(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: productColor,
                  ),
                )
              : Refresher(
                  refreshController: refreshController,
                  onLoading: inventory.rows!.length == inventory.count
                      ? null
                      : onLoading,
                  onRefresh: onRefresh,
                  color: productColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        inventory.rows!.isNotEmpty
                            ? Column(
                                children: inventory.rows!
                                    .map(
                                      (item) => GoodsCard(
                                        listenController: listenController,
                                        index: inventory.rows!.indexOf(item),
                                        startAnimation: startAnimation,
                                        data: item,
                                        priceClick: item.isPriceSet == false
                                            ? () {
                                                Navigator.of(context).pushNamed(
                                                  SetPrice.routeName,
                                                  arguments: SetPriceArguments(
                                                    data: item,
                                                    listenController:
                                                        listenController,
                                                  ),
                                                );
                                              }
                                            : () {},
                                        warehouseClick: item.isWarehouseSet ==
                                                false
                                            ? () {
                                                Navigator.of(context).pushNamed(
                                                  SetWarehouse.routeName,
                                                  arguments:
                                                      SetWarehouseArguments(
                                                    listenController:
                                                        listenController,
                                                    data: item,
                                                  ),
                                                );
                                              }
                                            : () {},
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            ProductDetailPage.routeName,
                                            arguments:
                                                ProductDetailPageArguments(
                                              id: item.id,
                                            ),
                                          );
                                        },
                                        inActiveClick: () async {
                                          if (inactiveTypes.rows!.isEmpty) {
                                            loading.loading(true);
                                            inactiveTypes = await InventoryApi()
                                                .inactiveTypeSelect();
                                            loading.loading(false);
                                          }
                                          await inactiveTypeSelect(
                                              item.variantId, "INACTIVE");
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : const NotFound(
                                module: 'INVENTORY',
                                labelText: "Бараа олдсонгүй",
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

  inactiveTypeSelect(String id, String status) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
            children: inactiveTypes.rows!
                .map(
                  (data) => GestureDetector(
                    onTap: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pushNamed(
                        PinCheckScreen.routeName,
                        arguments: PinCheckScreenArguments(
                          onSubmit: () {
                            inactive(id, "INACTIVE", data.id);
                          },
                          color: productColor,
                          labelText: "Бараа идэвхигүй болгох",
                        ),
                      );
                    },
                    child: Container(
                      color: transparent,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text("${data.text}"),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
