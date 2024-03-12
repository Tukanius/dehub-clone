import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/product_page/tabs/price_tab/components/price_setting_card.dart';
import 'package:dehub/src/product_module/screens/set_price_group/set_price_group.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PriceTab extends StatefulWidget {
  const PriceTab({super.key});

  @override
  State<PriceTab> createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  ListenController listenController = ListenController();
  InventoryGoods goods =
      InventoryGoods(rows: [], count: 0, coBusinessFinStaffs: []);
  List<InventoryGoods> priceList = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', excel: true);
    goods = await InventoryApi()
        .networkList(ResultArguments(offset: offset, filter: filter));
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
  void initState() {
    listenController.addListener(() async {
      setState(() {
        limit = 10;
        isLoading = true;
        priceList = [];
      });
      await list(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: productColor,
            ),
          )
        : Scaffold(
            backgroundColor: backgroundColor,
            floatingActionButton: priceList.isNotEmpty
                ? Material(
                    borderRadius: BorderRadius.circular(5),
                    color: productColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SetPriceGroup.routeName,
                          arguments: SetPriceGroupArguments(
                            list: priceList,
                            listenController: listenController,
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          'Үнэ тохируулах',
                          style: TextStyle(color: white),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            body: Refresher(
              onLoading: goods.rows!.length == goods.count ? null : onLoading,
              color: productColor,
              refreshController: refreshController,
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Харилцагчийн үнэ тохиргоо',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          goods.excelUrl != null
                              ? GestureDetector(
                                  onTap: () {
                                    launchUrl(goods.excelUrl!);
                                  },
                                  child: Container(
                                    color: transparent,
                                    padding: const EdgeInsets.all(3),
                                    child: const Icon(Icons.print_rounded),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    goods.rows!.isNotEmpty
                        ? Column(
                            children: goods.rows!.map((data) {
                              int index = priceList.indexWhere(
                                  (element) => element.id == data.id);
                              return PriceSettingCard(
                                list: priceList,
                                data: data,
                                onClick: () {
                                  if (index >= 0) {
                                    setState(() {
                                      priceList.removeAt(index);
                                    });
                                  } else {
                                    setState(() {
                                      priceList.add(data);
                                    });
                                  }
                                },
                                onChange: () {
                                  if (index >= 0) {
                                    setState(() {
                                      priceList.removeAt(index);
                                    });
                                  } else {
                                    setState(() {
                                      priceList.add(data);
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          )
                        : const NotFound(
                            module: "INVENTORY",
                            labelText: 'Хоосон байна',
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
