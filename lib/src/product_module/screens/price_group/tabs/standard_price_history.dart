import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/components/price_card/price_card.dart';
import 'package:dehub/src/product_module/screens/price_history_detail/price_group_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StandardPriceHistory extends StatefulWidget {
  const StandardPriceHistory({super.key});

  @override
  State<StandardPriceHistory> createState() => _StandardPriceHistoryState();
}

class _StandardPriceHistoryState extends State<StandardPriceHistory>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result prices = Result(rows: [], count: 0);
  final RefreshController refreshController = RefreshController();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "GROUP");
    prices = await InventoryApi()
        .priceGroupList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
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
            onLoading: prices.rows!.length == prices.count ? null : onLoading,
            onRefresh: onRefresh,
            color: productColor,
            child: SingleChildScrollView(
              child: prices.rows!.isNotEmpty
                  ? Column(
                      children: prices.rows!
                          .map(
                            (data) => PriceCard(
                              data: data,
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                  PriceGroupDetail.routeName,
                                  arguments: PriceGroupDetailArguments(
                                      id: data.id, type: 'GROUP'),
                                );
                              },
                            ),
                          )
                          .toList(),
                    )
                  : const NotFound(
                      module: 'INVENTORY',
                      labelText: "Хоосон байна",
                    ),
            ),
          );
  }
}
