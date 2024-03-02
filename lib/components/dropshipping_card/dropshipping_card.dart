import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DropshippingCard extends StatefulWidget {
  final Order data;
  final Function()? onClick;
  const DropshippingCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<DropshippingCard> createState() => _DropshippingCardState();
}

class _DropshippingCardState extends State<DropshippingCard> {
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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.data.salesCode}",
              style: const TextStyle(
                color: orderColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              receiver
                  ? 'Бизнес: ${widget.data.senderBusiness?.profileName}, ${widget.data.senderBusiness?.refCode}'
                  : 'Бизнес: ${widget.data.receiverBusiness?.profileName}, ${widget.data.receiverBusiness?.refCode}',
              style: const TextStyle(
                color: grey2,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ажилтан: ${widget.data.receiverStaff?.lastName?[0]}. ${widget.data.receiverStaff?.firstName}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Хүргэх: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.data.deliveryDate.toString()))}',
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
