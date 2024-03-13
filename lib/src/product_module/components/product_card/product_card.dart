import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatefulWidget {
  final Function()? buttonClick;
  final InventoryGoods data;
  const ProductCard({
    super.key,
    this.buttonClick,
    required this.data,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                '${widget.data.image}',
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: SizedBox(
                  height: 40,
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: white,
                    onPressed: widget.buttonClick,
                    child: const Icon(
                      Icons.add_shopping_cart,
                      color: buttonColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${widget.data.nameMon}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          RatingBar(
            itemSize: 12,
            initialRating: 3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star,
                color: orange,
              ),
              half: const Icon(
                Icons.star_half,
                color: orange,
              ),
              empty: const Icon(
                Icons.star_border,
                color: orange,
              ),
            ),
            onRatingUpdate: (rating) {},
          ),
          const SizedBox(
            height: 7,
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: const TextStyle(
                  fontFamily: 'Montserrat', fontSize: 16, color: black),
              children: [
                TextSpan(text: '${widget.data.skuCode} '),
                TextSpan(text: '${widget.data.barCode} '),
                TextSpan(text: '${widget.data.erpCode} '),
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Text(
                '₮${Utils().formatCurrency(widget.data.customPrice.toString())}',
                style: const TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                '₮${Utils().formatCurrency(widget.data.standardPrice.toString())}',
                style: const TextStyle(
                  fontSize: 20,
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: grey3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
