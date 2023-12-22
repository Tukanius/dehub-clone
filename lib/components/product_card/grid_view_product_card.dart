import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GridViewProductCard extends StatefulWidget {
  final InventoryGoods data;
  final Function()? buttonClick;
  const GridViewProductCard({
    Key? key,
    this.buttonClick,
    required this.data,
  }) : super(key: key);

  @override
  State<GridViewProductCard> createState() => _GridViewProductCardState();
}

class _GridViewProductCardState extends State<GridViewProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: white,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  '${widget.data.image}',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: FloatingActionButton.small(
                  shape: CircleBorder(),
                  backgroundColor: white,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: buttonColor,
                    size: 24,
                  ),
                  onPressed: widget.buttonClick,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '${widget.data.nameMon}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                textAlign: TextAlign.left,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontSize: 14, color: black),
                  children: [
                    TextSpan(text: '${widget.data.skuCode} '),
                    TextSpan(text: '${widget.data.barCode} '),
                    TextSpan(text: '${widget.data.erpCode} '),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '₮${Utils().formatCurrency(widget.data.standardPrice.toString())}',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                '₮${Utils().formatCurrency(widget.data.customPrice.toString())}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: grey3,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          )
        ],
      ),
    );
  }
}
