import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/tag/add_tag_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventoryTag extends StatefulWidget {
  static const routeName = '/InventoryTag';
  const InventoryTag({super.key});

  @override
  State<InventoryTag> createState() => _InventoryTagState();
}

class _InventoryTagState extends State<InventoryTag> with AfterLayoutMixin {
  int page = 1;
  int limit = 20;
  User user = User();
  bool isLoading = true;
  List<InventoryGoods> groupList = [];
  Result distributor = Result(rows: [], count: 0);
  Map<String, List<InventoryGoods>> groupItems = {};
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    distributor = await InventoryApi()
        .tagList(ResultArguments(offset: offset, filter: filter));
    groupMaker();
    setState(() {
      isLoading = false;
    });
  }

  groupMaker() {
    List<InventoryGoods> group = [];
    for (var item in distributor.rows!) {
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

  onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      groupItems = {};
      page = 1;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
          'Tag',
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
            useSafeArea: true,
            builder: (context) => AddTagSheet(),
          );
        },
        shape: CircleBorder(),
        backgroundColor: productColor,
        child: Icon(Icons.add, color: white),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              color: productColor,
              onLoading: onLoading,
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: groupList.length != 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: groupList
                            .map(
                              (data) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data.businessId == user.currentBusinessId
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text('Бүртгэсэн жагсаалт'),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text('Системд зориулсан'),
                                        ),
                                  Column(
                                    children: data.values!
                                        .map(
                                          (item) => Container(
                                            color: white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${item.text}',
                                                  style: TextStyle(color: dark),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/svg/edit_rounded.svg',
                                                  colorFilter: ColorFilter.mode(
                                                    productColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                        module: "INVENTORY",
                        labelText: 'Хоосон байна',
                      ),
              ),
            ),
    );
  }
}
