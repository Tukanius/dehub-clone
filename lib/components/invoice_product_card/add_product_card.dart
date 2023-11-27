import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/checkout-provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddProductCard extends StatefulWidget {
  final Function()? closeClick;
  final Function()? onClick;
  final bool? readOnly;
  final ListenController? listenController;
  final Invoice data;
  final bool? isPackage;
  final List<Invoice>? package;
  const AddProductCard({
    this.listenController,
    this.readOnly,
    this.package,
    this.isPackage,
    this.closeClick,
    this.onClick,
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> {
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
        if (widget.isPackage == true) {
          orderCart(widget.data, widget.data.quantity!);
        }
        widget.listenController?.changeVariable('decrease');
        removeCart(widget.data.quantity!);
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
      if (widget.isPackage == true) {
        orderCart(widget.data, widget.data.quantity!);
      }
      widget.listenController?.changeVariable('increase');
    });
  }

  orderCart(Invoice product, int qty) {
    int? index;
    try {
      index = widget.package?.indexWhere((item) => item.id == product.id);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (index! > -1) {
      if (widget.package?[index].quantity != 0) {
        widget.package?[index].quantity = qty;
      } else {
        widget.package?.removeAt(index);
      }
    } else {
      setState(() {
        widget.package?.add(
          product,
        );
      });
    }
  }

  removeCart(int quantity) {
    if (quantity == 0) {
      Provider.of<CheckOutProvider>(context, listen: false)
          .removeCart(widget.data);
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.quantity == null) {
      quantityController.text = '0';
    } else {
      quantityController.text = widget.data.quantity.toString();
    }
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.package?.contains(widget.data) == true
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
                Container(
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
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data.nameMon != null
                          ? Text(
                              '${widget.data.nameMon}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              '${widget.data.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          style:
                              TextStyle(fontFamily: 'Montserrat', color: black),
                          children: [
                            widget.data.skuCode != null
                                ? TextSpan(text: '${widget.data.skuCode} ')
                                : TextSpan(),
                            widget.data.barCode != null
                                ? TextSpan(text: '${widget.data.barCode} ')
                                : TextSpan(),
                            widget.data.erpCode != null
                                ? TextSpan(text: '${widget.data.erpCode} ')
                                : TextSpan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                widget.closeClick != null
                    ? GestureDetector(
                        onTap: widget.closeClick,
                        child: SvgPicture.asset(
                          'assets/svg/close.svg',
                          colorFilter: ColorFilter.mode(grey3, BlendMode.srcIn),
                          height: 20,
                          width: 20,
                        ),
                      )
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              color: invoiceColor,
                              width: 2,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: invoiceColor,
                          value: isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = value!;
                            });
                          },
                        ),
                      ),
              ],
            ),
            Divider(
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
                        Text(
                          'Нэгж үнэ',
                          style: TextStyle(
                            color: Color(0xff8181A5),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${Utils().formatCurrency(widget.data.price.toString())}₮',
                          style: TextStyle(
                            color: invoiceColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Ширхэг',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Хөнгөлөлт',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff8181A5),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.data.discountType == "PERCENTAGE"
                            ? Text(
                                '${widget.data.discountValue?.toInt()}%',
                                style: TextStyle(
                                  color: invoiceColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            : widget.data.discountType == "AMOUNT"
                                ? Text(
                                    '${widget.data.discountValue?.toInt()}₮',
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  )
                                : Text(
                                    '0₮',
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                        SizedBox(
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
                            color: Color(0xffEBFAFA),
                          ),
                          child: widget.data.discountType == "PERCENTAGE"
                              ? Text(
                                  'хувиар',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: grey2,
                                  ),
                                )
                              : Text(
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
                        child: Icon(
                          Icons.remove,
                          color: invoiceColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 70,
                      child: FormTextField(
                        readOnly: widget.readOnly!,
                        onChanged: (value) {
                          setState(() {
                            widget.data.quantity =
                                int.tryParse(quantityController.text) ?? 0;
                          });
                          widget.listenController?.changeVariable('zxcv');
                        },
                        fontSize: 18,
                        inputType: TextInputType.number,
                        controller: quantityController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 15,
                          ),
                          hintText: '0',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 5),
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
                    SizedBox(
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
                        child: Icon(
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
            Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: grey2,
                        ),
                      )
                    : Text(
                        '${Utils().formatCurrency((double.parse(quantityController.text.toString()) * widget.data.price!).toString())} ₮',
                        style: TextStyle(
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
