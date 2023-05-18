import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoiceConditionCard extends StatefulWidget {
  String? labelText;
  String? description;
  int? index;
  final Function()? onClick;
  InvoiceConditionCard({
    Key? key,
    this.onClick,
    this.description,
    this.labelText,
    this.index,
  }) : super(key: key);

  @override
  State<InvoiceConditionCard> createState() => _InvoiceConditionCardState();
}

class _InvoiceConditionCardState extends State<InvoiceConditionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffF2F2F2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.index! + 1}',
                  style: TextStyle(
                    color: grey3,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.labelText}',
                      style: TextStyle(
                        color: networkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Нэхэмжлэх нөхцөл',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.description}',
                      style: TextStyle(
                        fontSize: 12,
                        color: grey3,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
