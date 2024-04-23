import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/sheets/add_dynamic_information_sheet.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class DynamicInformation extends StatefulWidget {
  static const routeName = '/DynamicInformation';
  const DynamicInformation({super.key});

  @override
  State<DynamicInformation> createState() => _DynamicInformationState();
}

class _DynamicInformationState extends State<DynamicInformation>
    with AfterLayoutMixin {
  User user = User();
  bool isLoading = true;
  List<InventoryGoods> groupList = [];
  Map<String, List<InventoryGoods>> groupItems = {};
  Result dynamic = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list() async {
    dynamic = await InventoryApi().sectionSelect();
    groupMaker();
    setState(() {
      isLoading = false;
    });
  }

  onLoading() {
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      groupItems = {};
    });
    await list();
    refreshController.refreshCompleted();
  }

  groupMaker() {
    List<InventoryGoods> group = [];
    for (var item in dynamic.rows!) {
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Барааны динамик мэдээлэл',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton:
          Permission().check(user, "ERP_REF_SCTN", boolean: 'isCreate')
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) => const AddDinamycInformation(),
                    );
                  },
                  shape: const CircleBorder(),
                  backgroundColor: productColor,
                  child: const Icon(
                    Icons.add,
                    color: white,
                  ),
                )
              : null,
      body: isLoading == true
          ? const Center(
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
                child: Column(
                  children: groupList
                      .map(
                        (data) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: data.businessId == user.currentBusinessId
                                  ? const Text('Бүртгэсэн жагсаалт')
                                  : const Text('Системд тохируулсан'),
                            ),
                            Column(
                              children: data.values!
                                  .map(
                                    (item) => FieldCard(
                                      paddingHorizontal: 15,
                                      paddingVertical: 10,
                                      color: white,
                                      labelText: item.name,
                                      secondText: '',
                                      onClick: () {},
                                      arrowColor: productColor,
                                      secondTextColor: productColor,
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
