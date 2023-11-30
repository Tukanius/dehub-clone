import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatefulWidget {
  final bool? ratingBar;
  const ProductCard({
    Key? key,
    this.ratingBar,
  }) : super(key: key);

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
              Container(
                child: Image(
                  image: AssetImage(
                    'images/juice.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: SizedBox(
                  height: 40,
                  child: FloatingActionButton(
                    backgroundColor: white,
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: buttonColor,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Гүзээлзгэнэтэй иогурт',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          RatingBar(
            itemSize: 12,
            initialRating: 3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star,
                color: orange,
              ),
              half: Icon(
                Icons.star_half,
                color: orange,
              ),
              empty: Icon(
                Icons.star_border,
                color: orange,
              ),
            ),
            onRatingUpdate: (rating) {},
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'SKU 32165456, Brand Name, 250 гр, савлагааны нэр боөрсорыбх',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Text(
                '₮ 6800.00',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                '₮ 6800.00',
                style: TextStyle(
                  fontSize: 20,
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: grey3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
