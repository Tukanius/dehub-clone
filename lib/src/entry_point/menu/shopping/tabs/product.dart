import 'package:dehub/components/product_card/grid_view_product_card.dart';
import 'package:dehub/components/product_card/product_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final bool? gridview;
  const Product({
    this.gridview,
    super.key,
  });

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return widget.gridview == true
        ? GridView.count(
            childAspectRatio: 2 / 3,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: <Widget>[
              for (var i = 0; i < 4; i++)
                GridViewProductCard(
                  data: InventoryGoods(),
                ),
            ],
          )
        // ? Column(
        // children: [
        // Row(
        // children: [
        // Expanded(child: GridViewProductCard()),
        // Expanded(child: GridViewProductCard()),
        // ],
        // ),
        // ],
        // )
        : ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => ProductCard(
              data: InventoryGoods(),
            ),
          );
  }
}
