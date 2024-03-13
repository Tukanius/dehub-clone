import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/checkout_provider.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InvoiceProductCard extends StatefulWidget {
  final Function()? closeClick;
  final Function()? onClick;
  final bool? readOnly;
  final Invoice data;
  final bool? isPackage;
  final String discountAmount;
  final String shippingAmount;
  const InvoiceProductCard({
    required this.discountAmount,
    required this.shippingAmount,
    this.readOnly,
    this.isPackage,
    this.closeClick,
    this.onClick,
    super.key,
    required this.data,
  });

  @override
  State<InvoiceProductCard> createState() => _InvoiceProductCardState();
}

class _InvoiceProductCardState extends State<InvoiceProductCard> {
  String? discount;
  bool isCheck = false;
  TextEditingController quantityController = TextEditingController();
  bool isLoading = false;

  decrease() {
    if (widget.data.quantity! > 0) {
      setState(() {
        int newValue = 0;
        int currentValue = int.tryParse(quantityController.text) ?? 0;
        newValue = currentValue - 1;
        quantityController.text = newValue.toString();
        widget.data.quantity = int.parse(quantityController.text.toString());
      });
    }
  }

  increase() {
    setState(() {
      int newValue = 0;
      int currentValue = int.tryParse(quantityController.text) ?? 0;
      newValue = currentValue + 1;
      quantityController.text = newValue.toString();
      widget.data.quantity = int.parse(quantityController.text.toString());
    });
  }

  removeCart(int quantity) {
    if (quantity == 0) {
      Provider.of<CheckOutProvider>(context, listen: false)
          .removeCart(widget.data);
    }
  }

  @override
  void initState() {
    final source = Provider.of<InvoiceProvider>(context, listen: false);
    if (widget.data.quantity != null) {
      quantityController.text = widget.data.quantity.toString();
    }
    source.addListener(() {
      if (widget.data.quantity != null) {
        quantityController.text = widget.data.quantity.toString();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: source.packageProduct.contains(widget.data) &&
                    widget.isPackage == true
                ? invoiceColor
                : white,
          ),
          color: white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: widget.data.image != null
                      ? Image(
                          image: NetworkImage('${widget.data.image}'),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 56,
                          width: 56,
                          color: grey,
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data.nameMon != null
                          ? Text(
                              '${widget.data.nameMon}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              '${widget.data.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontFamily: 'Montserrat', color: black),
                          children: [
                            widget.data.skuCode != null
                                ? TextSpan(text: '${widget.data.skuCode} ')
                                : const TextSpan(),
                            widget.data.barCode != null
                                ? TextSpan(text: '${widget.data.barCode} ')
                                : const TextSpan(),
                            widget.data.erpCode != null
                                ? TextSpan(text: '${widget.data.erpCode} ')
                                : const TextSpan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (widget.closeClick != null)
                  GestureDetector(
                    onTap: widget.closeClick,
                    child: SvgPicture.asset(
                      'assets/svg/close.svg',
                      colorFilter:
                          const ColorFilter.mode(grey3, BlendMode.srcIn),
                      height: 20,
                      width: 20,
                    ),
                  )
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Нэгж үнэ',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${Utils().formatCurrency(widget.data.price.toString())}₮',
                          style: const TextStyle(
                            color: invoiceColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Ширхэг',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Хөнгөлөлт',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff8181A5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.data.discountType == "PERCENTAGE"
                            ? Text(
                                '${widget.data.discountValue?.toInt()}%',
                                style: const TextStyle(
                                  color: invoiceColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            : widget.data.discountType == "AMOUNT"
                                ? Text(
                                    '${widget.data.discountValue?.toInt()}₮',
                                    style: const TextStyle(
                                      color: invoiceColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  )
                                : const Text(
                                    '0₮',
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: grey3.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffEBFAFA),
                          ),
                          child: widget.data.discountType == "PERCENTAGE"
                              ? const Text(
                                  'хувиар',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: grey2,
                                  ),
                                )
                              : const Text(
                                  'дүнгээр',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: grey2,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.readOnly == false) {
                          decrease();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(color: invoiceColor),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: invoiceColor,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 70,
                      child: FormTextField(
                        readOnly: widget.readOnly!,
                        onChanged: (value) {
                          widget.data.quantity =
                              int.tryParse(quantityController.text) ?? 0;
                          if (widget.isPackage == true) {
                            if (widget.data.quantity == 0) {
                              source.packageProductRemove(widget.data);
                            } else {
                              source.packageProductAdd(
                                  widget.data, int.tryParse(value) ?? 0);
                            }
                          }
                          if (widget.isPackage == null &&
                              widget.data.quantity == 0) {
                            source.removeCart(widget.data,
                                widget.discountAmount, widget.shippingAmount);
                          }
                          source.totalAmountInvoice(
                              widget.discountAmount, widget.shippingAmount);
                        },
                        fontSize: 18,
                        inputType: TextInputType.number,
                        controller: quantityController,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 15,
                          ),
                          hintText: '0',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Color(0xffD9DCDE),
                            ),
                          ),
                        ),
                        name: 'quantity',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.readOnly == false) {
                          increase();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 13),
                        decoration: BoxDecoration(
                          color: invoiceColor,
                          border: Border.all(color: invoiceColor),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дүн:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: grey2,
                  ),
                ),
                widget.data.quantity != null
                    ? Text(
                        '${Utils().formatCurrency((widget.data.quantity! * widget.data.price!).toString())} ₮',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: grey2,
                        ),
                      )
                    : Text(
                        '${Utils().formatCurrency(((double.tryParse(quantityController.text.toString()) ?? 0) * widget.data.price!).toString())} ₮',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: grey2,
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
