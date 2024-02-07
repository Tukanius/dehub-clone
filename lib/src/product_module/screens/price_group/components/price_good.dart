import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PriceGoodCard extends StatefulWidget {
  final InventoryGoods data;
  final Function()? onClick;
  const PriceGoodCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<PriceGoodCard> createState() => _PriceGoodCardState();
}

class _PriceGoodCardState extends State<PriceGoodCard> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(bottom: 3),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 3,
                        color: Colors.grey,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.data.image}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data.variant?.nameMon}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: productColor,
                        ),
                      ),
                      Text(
                        'SKU: ${widget.data.skuCode ?? widget.data.variant?.skuCode}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: grey2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Нэр: ',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.data.name}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Хэмжих нэгж: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${widget.data.unitName}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: green,
                    ),
                  ),
                  child: const Text(
                    'ИДЭВХТЭЙ',
                    style: TextStyle(
                      fontSize: 12,
                      color: green,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: lightGrey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RotatedBox(
                quarterTurns: 2,
                child: Scrollbar(
                  thickness: 2,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  child: SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Эхэлсэн огноо',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd HH:mm').format(
                                    DateTime.parse(
                                        widget.data.startDate.toString())),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title('Стандарт үнэ'),
                              text(
                                  "${Utils().formatCurrency(widget.data.standardPrice.toString())}₮"),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[0].name ??
                                  'Tier${general.tiers?[0].tierNo}'),
                              text(widget.data.tier1Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier1Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[1].name ??
                                  'Tier${general.tiers?[1].tierNo}'),
                              text(widget.data.tier2Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier2Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[2].name ??
                                  'Tier${general.tiers?[2].tierNo}'),
                              text(widget.data.tier3Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier3Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[3].name ??
                                  'Tier${general.tiers?[3].tierNo}'),
                              text(widget.data.tier4Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier4Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[4].name ??
                                  'Tier${general.tiers?[4].tierNo}'),
                              text(widget.data.tier5Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier5Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[5].name ??
                                  'Tier${general.tiers?[5].tierNo}'),
                              text(widget.data.tier6Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier6Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[6].name ??
                                  'Tier${general.tiers?[6].tierNo}'),
                              text(widget.data.tier7Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier7Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[7].name ??
                                  'Tier${general.tiers?[7].tierNo}'),
                              text(widget.data.tier8Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier8Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[8].name ??
                                  'Tier${general.tiers?[8].tierNo}'),
                              text(widget.data.tier9Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier9Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(general.tiers?[9].name ??
                                  'Tier${general.tiers?[9].tierNo}'),
                              text(widget.data.tier10Price != null
                                  ? '${Utils().formatCurrency(widget.data.tier10Price.toString())}₮'
                                  : '-'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String? value) {
    return Text(
      "$value",
      style: const TextStyle(
        fontSize: 14,
        color: grey2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget text(String? value) {
    return Text(
      "$value",
      style: const TextStyle(
        fontSize: 14,
        color: grey2,
      ),
    );
  }
}
