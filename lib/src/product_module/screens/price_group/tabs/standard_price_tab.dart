import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/price_group/components/price_good.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class StandardPriceTab extends StatefulWidget {
  const StandardPriceTab({super.key});

  @override
  State<StandardPriceTab> createState() => _StandardPriceTabState();
}

class _StandardPriceTabState extends State<StandardPriceTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result prices = Result(rows: [], count: 0);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(categoryId: '');
    prices = await InventoryApi()
        .priceGroupGoods(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: productColor,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: prices.rows!
                      .map(
                        (data) => PriceGoodCard(
                          data: data,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
  }
}
