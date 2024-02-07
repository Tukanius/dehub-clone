import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/goods_price_change_history/goods_price_change_history.dart';
import 'package:dehub/src/product_module/screens/price_group/components/price_good.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StandardPriceTab extends StatefulWidget {
  const StandardPriceTab({super.key});

  @override
  State<StandardPriceTab> createState() => _StandardPriceTabState();
}

class _StandardPriceTabState extends State<StandardPriceTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result prices = Result(rows: [], count: 0);
  final RefreshController refreshController = RefreshController();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(categoryId: '');
    prices = await InventoryApi()
        .priceGroupGoods(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: productColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: productColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: prices.rows!
                        .map(
                          (data) => PriceGoodCard(
                            data: data,
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                GoodsPriceChangeHistory.routeName,
                                arguments: GoodsPriceChangeHistoryArguments(
                                    id: data.variantId),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
  }
}
