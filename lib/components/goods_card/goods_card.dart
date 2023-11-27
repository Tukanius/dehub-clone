import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GoodsCard extends StatefulWidget {
  final Function()? onClick;
  final InventoryGoods data;
  const GoodsCard({
    Key? key,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<GoodsCard> createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  image: NetworkImage('${widget.data.image}'),
                  fit: BoxFit.cover,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontFamily: 'Montserrat'),
                            children: [
                              TextSpan(
                                text: '${widget.data.nameMon}',
                                style: TextStyle(
                                  color: grey2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              widget.data.optionValues?.length != 0 &&
                                      widget.data.optionValues != null
                                  ? TextSpan(
                                      text: ': ',
                                      style: TextStyle(
                                        color: grey2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : TextSpan(),
                              widget.data.optionValues?.length != 0 &&
                                      widget.data.optionValues != null
                                  ? TextSpan(
                                      children: widget.data.optionValues!
                                          .map(
                                            (e) => TextSpan(
                                              text: widget.data.optionValues!
                                                          .last ==
                                                      true
                                                  ? "${e.name}, "
                                                  : "${e.name}",
                                              style: TextStyle(
                                                color: grey2,
                                                fontSize: 13,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : TextSpan(),
                            ],
                          ),
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
                    'SKU: ${widget.data.skuCode}',
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
                          widget.data.itemUnit?.unit?.name == null
                              ? Text(
                                  '-',
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  '${widget.data.itemUnit?.unit?.name}',
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 12,
                                  ),
                                ),
                        ],
                      ),
                      Text(
                        'Үлдэгдэл: ${widget.data.availableQuantity?.toInt()}',
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
                    '${widget.data.category?.name}',
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
