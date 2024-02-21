import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:after_layout/after_layout.dart';
import '../components/product_card.dart';

class RemainingStock extends StatefulWidget {
  const RemainingStock({super.key});

  @override
  State<RemainingStock> createState() => _RemainingStockState();
}

class _RemainingStockState extends State<RemainingStock> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result stock = Result(rows: [], count: 0);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(categoryId: '');
    stock = await InventoryApi()
        .stockList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    filterModal();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Шүүлт',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 12,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/filter_horizontal.svg',
                          height: 20,
                          width: 20,
                          colorFilter:
                              const ColorFilter.mode(grey2, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: stock.rows!
                      .map(
                        (data) => ProductCard(
                          border: false,
                          data: data,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
  }

  filterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: white,
        ),
        child: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}