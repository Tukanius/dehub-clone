import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/goods_card/goods_card.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/product_page/tabs/dashboard_tab/product_detail_page/product_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class GoodsTab extends StatefulWidget {
  const GoodsTab({super.key});

  @override
  State<GoodsTab> createState() => _GoodsTabState();
}

class _GoodsTabState extends State<GoodsTab> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result inventory = Result(rows: [], count: 0);

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  list(page, limit) async {
    Filter filter = Filter();
    Offset offset = Offset(page: page, limit: limit);
    Result res = await InventoryApi()
        .listGoods(ResultArguments(filter: filter, offset: offset));
    setState(() {
      inventory = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              children: [
                Container(
                  color: white,
                  height: 50,
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey3.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: SvgPicture.asset(
                            'images/yuluur.svg',
                            color: grey2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: grey3.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.search,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey3.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: SvgPicture.asset(
                              'images/filter.svg',
                              color: grey2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: productColor,
                  ),
                )
              : inventory.rows!.length != 0
                  ? Column(
                      children: inventory.rows!
                          .map(
                            (item) => GoodsCard(
                              data: item,
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                  ProductDetailPage.routeName,
                                  arguments: ProductDetailPageArguments(
                                    id: item.id,
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    )
                  : InvoiceEmpty(),
        ],
      ),
    );
  }
}
