import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SupplierCard extends StatefulWidget {
  final bool? shoppingCard;
  final bool? boxShadow;
  final Function()? onClick;
  final Invoice data;
  const SupplierCard({
    required this.data,
    this.boxShadow,
    this.shoppingCard,
    super.key,
    this.onClick,
  });

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
                    offset: const Offset(0, 1),
                  )
                : BoxShadow(
                    color: Colors.grey.withOpacity(0),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data.partner?.logo != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${widget.data.partner?.logo}'),
                        )
                      : const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/avatar.png'),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data.profileName}",
                          style: const TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.data.partner?.businessName}, ${widget.data.partner?.refCode}',
                          style: const TextStyle(
                            color: dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
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
