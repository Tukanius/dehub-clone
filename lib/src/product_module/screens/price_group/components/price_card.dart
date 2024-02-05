import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatefulWidget {
  final InventoryGoods data;
  const PriceCard({
    super.key,
    required this.data,
  });

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  General general = General();

  groupStatus() {
    final res = general.priceGroupStatus!
        .firstWhere((element) => element.code == widget.data.priceGroupStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.data.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: productColor,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Барааны тоо: ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${widget.data.variantCount ?? '-'}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
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
                child: Text(
                  "Эхлэх: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.data.startDate!))}",
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.data.endDate != null
                      ? "Дуусах: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.data.endDate!))}"
                      : "Дуусах: -",
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Тайлбар: ${widget.data.description}",
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${groupStatus().name}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: lightGrey,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage:
                      NetworkImage('${widget.data.regUser?.avatar}'),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      color: grey2,
                    ),
                    children: [
                      TextSpan(
                        text: '${widget.data.regUser?.lastName} ',
                      ),
                      TextSpan(text: '${widget.data.regUser?.firstName}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
