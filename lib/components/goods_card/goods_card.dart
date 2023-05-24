import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GoodsCard extends StatefulWidget {
  final Function()? onClick;
  const GoodsCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<GoodsCard> createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 90,
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage('images/map.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Барааны нэр',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: grey2,
                        size: 14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'SKU: 8987323972389',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Нэгж: ',
                            style: TextStyle(
                              color: grey2,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Ширхэг',
                            style: TextStyle(
                              color: green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Үлдэгдэл',
                        style: TextStyle(
                          color: productColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Ангилал',
                    style: TextStyle(color: grey2, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
