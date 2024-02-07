import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart' as model;
import 'package:dehub/src/product_module/screens/price_group/components/price_good.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsPriceChangeHistoryArguments {
  String id;
  GoodsPriceChangeHistoryArguments({
    required this.id,
  });
}

class GoodsPriceChangeHistory extends StatefulWidget {
  static const routeName = '/GoodsPriceChangeHistory';
  final String id;
  const GoodsPriceChangeHistory({
    super.key,
    required this.id,
  });

  @override
  State<GoodsPriceChangeHistory> createState() =>
      _GoodsPriceChangeHistoryState();
}

class _GoodsPriceChangeHistoryState extends State<GoodsPriceChangeHistory>
    with AfterLayoutMixin {
  InventoryGoods variant = InventoryGoods();
  int page = 1;
  int limit = 10;
  model.Result history = model.Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController = RefreshController();

  @override
  afterFirstLayout(BuildContext context) async {
    variant = await InventoryApi().priceGroupVariantGet(widget.id);
    await list(page, limit);
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  list(page, limit) async {
    model.Offset offset = model.Offset(page: page, limit: limit);
    model.Filter filter = model.Filter(variantId: variant.id);
    history = await InventoryApi().priceGroupVariantHistory(
        model.ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: productColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Барааны үнийн өөрчлөлт',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
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
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: grey,
                              image: DecorationImage(
                                image: NetworkImage('${variant.image}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: black, fontFamily: "Montserrat"),
                                    children: [
                                      const TextSpan(text: 'Нэр: '),
                                      TextSpan(
                                        text: variant.nameMon,
                                        style: const TextStyle(
                                          color: productColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: black, fontFamily: "Montserrat"),
                                    children: [
                                      const TextSpan(text: 'DeHUB code: '),
                                      TextSpan(
                                        text: variant.refCode,
                                        style: const TextStyle(
                                          color: productColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: black, fontFamily: "Montserrat"),
                                    children: [
                                      const TextSpan(text: 'SKU: '),
                                      TextSpan(
                                        text: variant.skuCode,
                                        style: const TextStyle(
                                          color: productColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Өөрчлөлтийн түүх",
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Column(
                      children: history.rows!
                          .map(
                            (data) => PriceGoodCard(data: data),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
