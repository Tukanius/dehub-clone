import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/components/adjustment_card/adjustment_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  User user = User();

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
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: productColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading:
                adjustment.rows!.length == adjustment.count ? null : onLoading,
            onRefresh: onRefresh,
            color: productColor,
            child: SingleChildScrollView(
              child: adjustment.rows!.isNotEmpty
                  ? Column(
                      children: adjustment.rows!
                          .map(
                            (e) => AdjustmentCard(data: e),
                          )
                          .toList(),
                    )
                  : const NotFound(
                      module: "INVENTORY",
                      labelText: 'Хоосон байна',
                    ),
            ),
          );
  }
}
