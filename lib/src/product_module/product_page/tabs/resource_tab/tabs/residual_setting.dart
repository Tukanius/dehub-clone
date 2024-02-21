import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/product_page/tabs/resource_tab/components/adjustment_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ResidualSetting extends StatefulWidget {
  const ResidualSetting({super.key});

  @override
  State<ResidualSetting> createState() => _ResidualSettingState();
}

class _ResidualSettingState extends State<ResidualSetting>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result adjustment = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(warehouseId: '');
    adjustment = await InventoryApi()
        .adjustmentList(ResultArguments(filter: filter, offset: offset));
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
    list(page, limit);
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
                children: adjustment.rows!
                    .map(
                      (e) => AdjustmentCard(data: e),
                    )
                    .toList(),
              ),
            ),
          );
  }
}