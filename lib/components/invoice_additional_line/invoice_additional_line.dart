import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoiceAdditionalLine extends StatefulWidget {
  final Invoice? data;
  const InvoiceAdditionalLine({Key? key, this.data}) : super(key: key);

  @override
  State<InvoiceAdditionalLine> createState() => _InvoiceAdditionalLineState();
}

class _InvoiceAdditionalLineState extends State<InvoiceAdditionalLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.data?.name}'),
              SizedBox(
                height: 5,
              ),
              Text(
                '${Utils().formatCurrency(widget.data?.quantity.toString())} ш х ${Utils().formatCurrency(widget.data?.price.toString())}',
                style: TextStyle(
                  color: Color(0xff657786),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${Utils().formatCurrency(widget.data?.totalAmount.toString())} ₮',
                style: TextStyle(
                  color: invoiceColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: invoiceColor,
                size: 15,
              )
            ],
          ),
        ],
      ),
    );
  }
}
