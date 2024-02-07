import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AdjustmentCard extends StatefulWidget {
  final InventoryGoods data;
  const AdjustmentCard({
    super.key,
    required this.data,
  });

  @override
  State<AdjustmentCard> createState() => _AdjustmentCardState();
}

class _AdjustmentCardState extends State<AdjustmentCard> {
  General general = General();

  adjustmentStatus() {
    final res = general.adjustmentStatus!
        .firstWhere((element) => element.code == widget.data.adjustmentStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.data.refCode}',
                style: const TextStyle(
                  color: productColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.data.reference}',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: grey2,
                fontSize: 12,
              ),
              children: [
                const TextSpan(
                  text: 'Агуулах: ',
                ),
                TextSpan(
                  text:
                      '${widget.data.warehouse?.name}, ${widget.data.warehouse?.refCode}',
                  style: const TextStyle(color: productColor),
                ),
              ],
            ),
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
                      fontFamily: 'Montserrat',
                      color: grey2,
                      fontSize: 12,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Үүсгэсэн: ',
                      ),
                      TextSpan(
                        text: DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(widget.data.createdAt.toString())),
                        style: const TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '${adjustmentStatus().name}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                        "${widget.data.regUser?.avatar}",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: grey2,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      '${widget.data.regUser?.lastName?[0]}. ${widget.data.regUser?.firstName}')
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: grey2,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${widget.data.regUser?.phone}. ${widget.data.regUser?.email}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
