import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/goods_card/goods_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/product_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class GoodsTab extends StatefulWidget {
  const GoodsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<GoodsTab> createState() => _GoodsTabState();
}

class _GoodsTabState extends State<GoodsTab> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result inventory = Result(rows: [], count: 0);
  Timer? timer;
  bool isSubmit = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool startAnimation = false;

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
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String value) {
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
                      : inventory.rows!.length != 0
                          ? Column(
                              children: inventory.rows!
                                  .map(
                                    (item) => GoodsCard(
                                      index: inventory.rows!.indexOf(item),
                                      startAnimation: startAnimation,
                                      data: item,
                                      onClick: () {
                                        Navigator.of(context).pushNamed(
                                          ProductDetailPage.routeName,
                                          arguments: ProductDetailPageArguments(
                                            id: item.id,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : NotFound(
                              module: 'INVENTORY',
                              labelText: "Бараа олдсонгүй",
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
