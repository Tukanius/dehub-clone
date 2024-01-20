import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/update_sheet/update_sheet.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/item_type/add_item_type.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InventoryItemType extends StatefulWidget {
  static const routeName = '/InventoryItemType';
  const InventoryItemType({Key? key}) : super(key: key);

  @override
  State<InventoryItemType> createState() => _InventoryItemTypeState();
}

class _InventoryItemTypeState extends State<InventoryItemType>
    with AfterLayoutMixin {
  Result itemType = Result(rows: []);
  int page = 1;
  int limit = 20;
  bool isLoading = true;
  List<InventoryGoods> groupedList = [];
  Map<String, List<InventoryGoods>> groupItems = {};
  User user = User();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  groupMaker() {
    List<InventoryGoods> group = [];
    for (var item in itemType.rows!) {
      String businessId = item.businessId;
      if (groupItems.containsKey(businessId)) {
        groupItems[businessId]!.add(item);
      } else {
        groupItems[businessId] = [item];
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
    groupedList = group;
  }

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    itemType = await InventoryApi()
        .itemTypeList(ResultArguments(offset: offset, filter: filter));
    groupMaker();
    setState(() {
      isLoading = false;
    });
  }

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupItems = {};
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  update(InventoryGoods data) {
    updateSheet(context, updateClick: () {
      Navigator.of(context).pop();
      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (context) => AddItemType(
          data: data,
        ),
      );
    }, deleteClick: () async {
      await InventoryApi().itemTypeDelete(data.id!);
      await list(page, limit);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: productColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text(
          'Нэр төрөл',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddItemType(),
          );
        },
        shape: CircleBorder(),
        backgroundColor: productColor,
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              color: productColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: groupedList
                      .map(
                        (item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: user.currentBusinessId == item.businessId
                                  ? Text('Бүртгэсэн жагсаалт')
                                  : Text('Системд тохируулсан'),
                            ),
                            Column(
                              children: item.values!
                                  .map(
                                    (data) => Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      color: white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${data.name}',
                                              style: TextStyle(color: dark),
                                            ),
                                          ),
                                          user.currentBusinessId ==
                                                  item.businessId
                                              ? GestureDetector(
                                                  onTap: () {
                                                    update(data);
                                                    print(data.toJson());
                                                  },
                                                  child: Container(
                                                    color: transparent,
                                                    child: SvgPicture.asset(
                                                      'assets/svg/edit_rounded.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              productColor,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
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
