import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/goods_price_change_history/goods_price_change_history.dart';
import 'package:dehub/src/product_module/components/price_good/price_good.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
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
  User user = User();

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
    if (Permission().check(user, "ERP_STD_PRICE")) {
      await list(page, limit);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return Permission().check(user, "ERP_STD_PRICE")
        ? isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: productColor,
                ),
              )
            : Refresher(
                refreshController: refreshController,
                onLoading:
                    prices.rows!.length == prices.count ? null : onLoading,
                onRefresh: onRefresh,
                color: productColor,
                child: SingleChildScrollView(
                  child: prices.rows!.isNotEmpty
                      ? Column(
                          children: [
                            Column(
                              children: prices.rows!
                                  .map(
                                    (data) => PriceGoodCard(
                                      data: data,
                                      onClick: () {
                                        Navigator.of(context).pushNamed(
                                          GoodsPriceChangeHistory.routeName,
                                          arguments:
                                              GoodsPriceChangeHistoryArguments(
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
                        )
                      : const NotFound(
                          module: 'INVENTORY',
                          labelText: "Хоосон байна",
                        ),
                ),
              )
        : const NotFound(
            module: "INVENTORY",
            labelText: 'Хандах эрх хүрэлцэхгүй байна',
          );
  }
}
