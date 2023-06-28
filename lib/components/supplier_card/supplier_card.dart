import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SupplierCard extends StatefulWidget {
  final bool? shoppingCard;
  final bool? boxShadow;
  final Function()? onClick;
  final Invoice? data;
  const SupplierCard({
    this.data,
    this.boxShadow,
    this.shoppingCard,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<SupplierCard> createState() => _SupplierCardState();
}

class _SupplierCardState extends State<SupplierCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            widget.boxShadow == true
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  )
                : BoxShadow(
                    color: Colors.grey.withOpacity(0),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(0, 0),
                  ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data?.partner?.logo != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage('${widget.data?.partner?.logo}'),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/map.jpg'),
                      ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.data?.partnerName}",
                      style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.data?.partner?.businessName}',
                      style: TextStyle(
                        color: dark,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
