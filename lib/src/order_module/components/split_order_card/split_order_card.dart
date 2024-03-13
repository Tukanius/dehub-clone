import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SplitOrderCard extends StatefulWidget {
  final Order data;
  final Function()? onClick;
  const SplitOrderCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<SplitOrderCard> createState() => _SplitOrderCardState();
}

class _SplitOrderCardState extends State<SplitOrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.data.type == "SALES"
                            ? '${widget.data.receiverBusiness?.logo}'
                            : '${widget.data.senderBusiness?.logo}',
                      ),
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
                      Text(
                        widget.data.type == "SALES"
                            ? '${widget.data.receiverBusiness?.profileName}'
                            : '${widget.data.senderBusiness?.profileName}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.data.type == "SALES"
                            ? '${widget.data.receiverBusiness?.partner?.businessName}, ${widget.data.receiverBusiness?.partner?.refCode}'
                            : '${widget.data.senderBusiness?.partner?.businessName}, ${widget.data.senderBusiness?.partner?.refCode}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: grey2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.data.salesCode}',
                  style: const TextStyle(
                    color: orderColor,
                    fontWeight: FontWeight.w500,
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
                    'Бүс: ${widget.data.region?.name ?? "-"}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Чиглэл: ${widget.data.direction?.name ?? '-'}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
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
