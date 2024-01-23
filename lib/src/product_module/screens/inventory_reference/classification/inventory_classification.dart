import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/classification/add_classification.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class InventoryClassificationArguments {
  String type;
  InventoryClassificationArguments({
    required this.type,
  });
}

class InventoryClassification extends StatefulWidget {
  static const routeName = '/InventoryClassification';
  final String type;
  const InventoryClassification({
    super.key,
    required this.type,
  });

  @override
  State<InventoryClassification> createState() =>
      _InventoryClassificationState();
}

class _InventoryClassificationState extends State<InventoryClassification>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 20;
  Result list = Result(rows: []);
  bool isLoading = true;
  Map<String, List<InventoryGoods>> groupItems = {};
  List<InventoryGoods> groupList = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  User user = User();

  type() {
    switch (widget.type) {
      case "CLASSIFICATION":
        return 4;
      case "SUB_CLASSIFICATION":
        return 3;
      case "CATEGORY":
        return 2;
      case "SUB_CATEGORY":
        return 1;
      default:
    }
  }

  void onLoading() async {
    setState(() {
      page += 1;
    });
    await api(page, limit);
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupItems = {};
    });
    await api(page, limit);
    refreshController.refreshCompleted();
  }

  api(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: widget.type);
    list = await InventoryApi()
        .categoryList(ResultArguments(offset: offset, filter: filter));
    groupMaker();
    setState(() {
      isLoading = false;
    });
  }

  groupMaker() {
    List<InventoryGoods> group = [];
    for (var item in list.rows!) {
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
    Provider.of<InventoryProvider>(context, listen: false).clearData();
    api(page, limit);
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
          title: widget.type == "CLASSIFICATION"
              ? const Text(
                  'Ангилал',
                  style: TextStyle(color: productColor, fontSize: 16),
                )
              : widget.type == "SUB_CLASSIFICATION"
                  ? const Text(
                      'Дэд ангилал',
                      style: TextStyle(color: productColor, fontSize: 16),
                    )
                  : widget.type == "CATEGORY"
                      ? const Text(
                          'Категори',
                          style: TextStyle(color: productColor, fontSize: 16),
                        )
                      : const Text(
                          'Дэд категори',
                          style: TextStyle(color: productColor, fontSize: 16),
                        )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            builder: (context) => AddClassification(
              type: widget.type,
            ),
          );
        },
        backgroundColor: productColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: isLoading == true
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: groupList
                      .map(
                        (item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: item.businessId == user.currentBusinessId
                                  ? const Text('Бүртгэсэн жагсаалт')
                                  : const Text('Системд тохируулсан'),
                            ),
                            Column(
                              children: item.values!
                                  .map(
                                    (data) => GestureDetector(
                                      onTap: user.currentBusinessId ==
                                              item.businessId
                                          ? () {}
                                          : () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        color: white,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data.name}',
                                                    style: const TextStyle(
                                                        color: productColor),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: grey2,
                                                      ),
                                                      children: [
                                                        type() < 4
                                                            ? TextSpan(
                                                                text:
                                                                    "${data.classification?.name}, ")
                                                            : const TextSpan(),
                                                        type() < 3
                                                            ? TextSpan(
                                                                text:
                                                                    "${data.subClassification?.name}, ")
                                                            : const TextSpan(),
                                                        type() < 2
                                                            ? TextSpan(
                                                                text:
                                                                    "${data.category?.name}, ",
                                                              )
                                                            : const TextSpan(),
                                                        TextSpan(
                                                          text: data
                                                              .itemType?.name,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: productColor,
                                              size: 16,
                                            ),
                                          ],
                                        ),
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
