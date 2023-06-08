import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GridViewProductCard extends StatefulWidget {
  final bool? ratingBar;
  const GridViewProductCard({
    Key? key,
    this.ratingBar,
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
            children: [
              Container(
                color: white,
                height: 100,
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
          Column(
            children: [
              Text(
                'Гүзээлзгэнэтэй иогурт',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'SKU 32165456, Brand Name, 250 гр',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₮ 6800.00',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                '₮ 6800.00',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: grey3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
