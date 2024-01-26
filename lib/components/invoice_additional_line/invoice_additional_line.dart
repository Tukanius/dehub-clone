import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InvoiceAdditionalLine extends StatefulWidget {
  final Invoice? data;
  final int index;
  final bool newInvoice;
  final String discountAmount;
  final String shippingAmount;
  const InvoiceAdditionalLine({
    super.key,
    this.data,
    required this.shippingAmount,
    required this.discountAmount,
    required this.newInvoice,
    required this.index,
  });

  @override
  State<InvoiceAdditionalLine> createState() => _InvoiceAdditionalLineState();
}

class _InvoiceAdditionalLineState extends State<InvoiceAdditionalLine> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);
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
              const SizedBox(
                height: 5,
              ),
              Text(
                '${Utils().formatCurrency(widget.data?.quantity.toString())} ш х ${Utils().formatCurrency(widget.data?.price.toString())}',
                style: const TextStyle(
                  color: Color(0xff657786),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${Utils().formatCurrency((widget.data!.quantity! * widget.data!.price!).toString())} ₮',
                style: const TextStyle(
                  color: invoiceColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              widget.newInvoice == true
                  ? GestureDetector(
                      onTap: () {
                        source.additionalRowRemove(widget.index,
                            widget.discountAmount, widget.shippingAmount);
                      },
                      child: Container(
                        color: transparent,
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/svg/close.svg',
                          colorFilter:
                              const ColorFilter.mode(grey2, BlendMode.srcIn),
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.arrow_forward_ios,
                      color: invoiceColor,
                      size: 14,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
