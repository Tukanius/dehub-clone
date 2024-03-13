import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BackorderCard extends StatefulWidget {
  final Function()? onClick;
  final Order data;
  const BackorderCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<BackorderCard> createState() => BackorderCardState();
}

class BackorderCardState extends State<BackorderCard> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    bool receiver = user.currentBusiness?.type == "SUPPLIER" &&
            widget.data.type == "SALES" ||
        user.currentBusiness?.type == "BUYER" && widget.data.type == "PURCHASE";
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    receiver
                        ? '${widget.data.senderBusiness?.profileName}'
                        : '${widget.data.receiverBusiness?.profileName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.data.purchaseCode}',
                    style: const TextStyle(
                      color: orderColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
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
                    receiver
                        ? 'Партнер: ${widget.data.senderBusiness?.partner?.businessName}'
                        : 'Партнер: ${widget.data.receiverBusiness?.partner?.businessName}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Үлдэгдэл: ${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
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
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Захиалгын дүн: ${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                    style: const TextStyle(
                      color: depBrown,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Төлсөн: ${Utils().formatCurrency(widget.data.paidAmount.toString())}₮',
                    style: const TextStyle(
                      color: depBrown,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Хүргэх: ${DateFormat('yyyy-MM-dd').format(DateTime.parse("${widget.data.deliveryDate}"))}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Салбар: ${widget.data.receiverBranch?.name}',
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
