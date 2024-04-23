import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/components/update_sheet/update_sheet.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/adjustment_note/add_adjustment_note.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdjustmentNote extends StatefulWidget {
  static const routeName = '/AdjustmentNote';
  const AdjustmentNote({super.key});

  @override
  State<AdjustmentNote> createState() => _AdjustmentNoteState();
}

class _AdjustmentNoteState extends State<AdjustmentNote> with AfterLayoutMixin {
  int page = 1;
  int limit = 20;
  User user = User();
  bool isLoading = true;
  List<InventoryGoods> groupList = [];
  Result distributor = Result(rows: [], count: 0);
  Map<String, List<InventoryGoods>> groupItems = {};
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    distributor = await InventoryApi()
        .adjustmentNoteList(ResultArguments(offset: offset, filter: filter));
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
    await Future.delayed(const Duration(milliseconds: 1000));
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

  update(InventoryGoods data) {
    updateSheet(context, updateClick: () {
      if (Permission().check(user, "ERP_REF_ADJ_NOTE", boolean: 'isEdit')) {
        Navigator.of(context).pop();
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          builder: (context) => AddAdjustmentNote(
            name: data.name,
            id: data.id,
            listenController: listenController,
          ),
        );
      } else {
        showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
      }
    }, deleteClick: () async {
      if (Permission().check(user, "ERP_REF_ADJ_NOTE", boolean: 'isDelete')) {
        await InventoryApi().adjustmentNoteDel(data.id!);
        listenController.changeVariable('asdf');
        Navigator.of(context).pop();
      } else {
        showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
      }
    });
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
        groupItems = {};
        page = 1;
      });
      await list(page, limit);
    });
    super.initState();
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
          'Хөдөлгөөн шалтгаан',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton:
          Permission().check(user, "ERP_REF_ADJ_NOTE", boolean: 'isCreate')
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) => AddAdjustmentNote(
                        listenController: listenController,
                      ),
                    );
                  },
                  shape: const CircleBorder(),
                  backgroundColor: productColor,
                  child: const Icon(Icons.add, color: white),
                )
              : null,
      body: isLoading == true
          ? const Center(
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
                child: groupList.isNotEmpty
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
                                          child:
                                              const Text('Бүртгэсэн жагсаалт'),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child:
                                              const Text('Системд зориулсан'),
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
                                                  '${item.name}',
                                                  style: const TextStyle(
                                                      color: dark),
                                                ),
                                                if (data.businessId ==
                                                    user.currentBusinessId)
                                                  GestureDetector(
                                                    onTap: () {
                                                      update(item);
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/svg/edit_rounded.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        productColor,
                                                        BlendMode.srcIn,
                                                      ),
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
                    : const NotFound(
                        module: "INVENTORY",
                        labelText: 'Хоосон байна',
                      ),
              ),
            ),
    );
  }
}
