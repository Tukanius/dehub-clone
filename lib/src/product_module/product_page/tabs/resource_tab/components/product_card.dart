import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatefulWidget {
  final InventoryGoods data;
  final Function()? onClick;
  final bool border;
  const ProductCard({
    super.key,
    this.onClick,
    required this.border,
    required this.data,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(
              color: widget.border == true ? productColor : transparent),
        ),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage('${widget.data.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.data.nameMon}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('SKU: '),
                                Expanded(
                                  child: Text(
                                    '${widget.data.skuCode}',
                                    style: const TextStyle(color: productColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.data.refCode}',
                        style: const TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Нийт үлдэгдэл: '),
                        TextSpan(
                          text: '${widget.data.totalQuantity}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Боломжит үлдэгдэл: '),
                        TextSpan(
                          text: '${widget.data.availableQuantity?.toInt()}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Захиалгын нөөцөд: '),
                        TextSpan(
                          text: '${widget.data.reservedQuantity}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Борлуулалтад гарах: '),
                        TextSpan(
                          text: '${widget.data.loadingQuantity}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Хүргэлтэд яваа: '),
                        TextSpan(
                          text: '${widget.data.onDeliveryQuantity}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: grey2,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Минимум үлдэгдэл: '),
                        TextSpan(
                          text: '${widget.data.minQuantity}',
                          style: const TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
