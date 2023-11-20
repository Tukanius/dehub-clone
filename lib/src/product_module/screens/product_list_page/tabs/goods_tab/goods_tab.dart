import 'dart:async';

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
  const GoodsTab({super.key});

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
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchButton(
            onChange: (query) {
              onChange(query);
            },
            color: productColor,
            textColor: productColor,
            borderColor: productColor,
          ),
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
    );
  }
}
