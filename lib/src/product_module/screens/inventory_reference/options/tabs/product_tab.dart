import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({super.key});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result options = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(isGoods: true, isService: false);
    options = await InventoryApi()
        .optionList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text('Бүртгэсэн жагсаалт'),
          ),
        ],
      ),
    );
  }
}
