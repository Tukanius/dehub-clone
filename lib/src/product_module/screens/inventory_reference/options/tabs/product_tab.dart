import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/options/sheets/update_option_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({super.key});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> with AfterLayoutMixin {
  Result options = Result(rows: [], count: 0);
  List<InventoryGoods> groupList = [];
  Map<String, List<InventoryGoods>> groupItems = {};
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  User user = User();
  bool isLoading = true;

  list() async {
    options = await InventoryApi().optionSelect(true, false);
    groupMaker();
    setState(() {
      isLoading = false;
    });
  }

  onLoading() {
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      groupItems = {};
    });
    await list();
    refreshController.refreshCompleted();
  }

  groupMaker() {
    List<InventoryGoods> group = [];
    for (var item in options.rows!) {
      String businessId = item.businessId;
      if (businessId == user.currentBusinessId) {
        if (groupItems.containsKey(businessId)) {
          groupItems[businessId]!.add(item);
        } else {
          groupItems[businessId] = [item];
        }
      } else {
        if (groupItems.containsKey('1')) {
          groupItems['1']!.add(item);
        } else {
          groupItems['1'] = [item];
        }
      }
    }
    groupItems.forEach((key, value) {
      group.add(
        InventoryGoods(
          businessId: key,
          values: value,
        ),
      );
    });
    groupList = group;
  }

  @override
  afterFirstLayout(BuildContext context) {
    list();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: productColor,
            ),
          )
        : Refresher(
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: productColor,
            refreshController: refreshController,
            child: SingleChildScrollView(
              child: groupList.length != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: groupList
                          .map(
                            (data) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child:
                                      user.currentBusinessId == data.businessId
                                          ? Text('Бүртгэсэн жагсаалт')
                                          : Text('Системд тохируулсан'),
                                ),
                                Column(
                                  children: data.values!
                                      .map(
                                        (item) => FieldCard(
                                          paddingHorizontal: 15,
                                          paddingVertical: 10,
                                          color: white,
                                          labelText: '${item.name}',
                                          secondText:
                                              '${item.values?.length} хувилбар',
                                          secondTextColor: productColor,
                                          arrowColor: productColor,
                                          onClick: () {
                                            showModalBottomSheet(
                                              context: context,
                                              useSafeArea: true,
                                              builder: (context) =>
                                                  UpdateOptionSheet(
                                                data: item,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : NotFound(
                      module: 'INVENTORY',
                      labelText: "Хоосон байна",
                    ),
            ),
          );
  }
}
