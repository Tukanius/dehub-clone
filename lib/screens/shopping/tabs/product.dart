import 'package:dehub/components/product_card/grid_view_product_card.dart';
import 'package:dehub/components/product_card/product_card.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final bool? gridview;
  const Product({
    this.gridview,
    Key? key,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.5),
      crossAxisCount: widget.gridview != true ? 1 : 2,
      children: <Widget>[
        for (var i = 0; i < 4; i++)
          widget.gridview == true ? GridViewProductCard() : ProductCard()
      ],
    );
  }
}
