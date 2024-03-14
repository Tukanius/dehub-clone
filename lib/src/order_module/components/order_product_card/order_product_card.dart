import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/providers/checkout_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OrderProductCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? onCloseClick;
  final List<Order>? list;
  final Order data;
  final bool? readOnly;
  final List<Order>? package;
  final bool? isPackage;
  final ListenController? listenController;
  final Function()? checkbox;
  const OrderProductCard({
    this.listenController,
    this.checkbox,
    this.onCloseClick,
    this.list,
    this.isPackage,
    this.package,
    this.readOnly,
    super.key,
    required this.data,
    this.onClick,
  });

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  General general = General();
  int newValue = 0;

  removeCart(int? quantity) {
    if (quantity == 0) {
      Provider.of<CheckOutProvider>(context, listen: false)
          .orderRemoveCart(widget.data);
    }
  }

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
        removeCart(widget.data.quantity);
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

  orderCart(Order product, int qty) {
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

  discountType() {
    final res = general.discountTypes!
        .firstWhere((element) => element.code == widget.data.discountType);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).orderGeneral;
    if (widget.data.quantity == null) {
      quantityController.text = '0';
    } else {
      quantityController.text = widget.data.quantity.toString();
    }
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.package?.contains(widget.data) == true &&
                    widget.isPackage == true
                ? orderColor
                : transparent,
          ),
          color: white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data.image != null
                    ? Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage('${widget.data.image}'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              spreadRadius: 3,
                              color: lightGrey,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: grey,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              spreadRadius: 3,
                              color: lightGrey,
                            ),
                          ],
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
                                color: dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              '${widget.data.name}',
                              style: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: dark, fontFamily: 'Montserrat'),
                          children: [
                            widget.data.skuCode != null
                                ? TextSpan(text: "${widget.data.skuCode}, ")
                                : const TextSpan(),
                            widget.data.brand != null
                                ? TextSpan(text: "${widget.data.brand}, ")
                                : const TextSpan(),
                            widget.data.category != null
                                ? TextSpan(text: "${widget.data.category}, ")
                                : const TextSpan(),
                            widget.data.optionValues != null
                                ? TextSpan(
                                    text:
                                        "${widget.data.optionValues?.map((e) => e.name).join(', ')}",
                                  )
                                : const TextSpan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                widget.list == null
                    ? GestureDetector(
                        onTap: widget.onCloseClick,
                        child: SvgPicture.asset(
                          'assets/svg/close.svg',
                          colorFilter:
                              const ColorFilter.mode(grey3, BlendMode.srcIn),
                          height: 16,
                          width: 16,
                        ),
                      )
                    : Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                            color: orderColor,
                            width: 2,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: orderColor,
                        value: widget.list?.contains(widget.data),
                        onChanged: (value) {
                          if (widget.checkbox != null) {
                            widget.checkbox!();
                          }
                        },
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Нэгж',
                        style: TextStyle(
                          color: coolGrey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      widget.data.unit != null
                          ? Text(
                              '${widget.data.unit}',
                              style: const TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : const Text(
                              '-',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${widget.data.unitConvertValue} ш',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Нэгж үнэ',
                        style: TextStyle(
                          color: coolGrey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${Utils().formatCurrency(widget.data.price.toString())}₮',
                        style: const TextStyle(
                          color: orderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Text(
                      //   '${widget.data.unitConvertValue} ш',
                      //   style: const TextStyle(
                      //     color: dark,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                if (widget.data.discountType != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Хөнгөлөлт',
                          style: TextStyle(
                            color: coolGrey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${widget.data.discountValue?.toInt()} ${discountType().symbol}',
                          style: const TextStyle(
                            color: orderColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: grey3.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffEBFAFA),
                          ),
                          child: Text(
                            discountType().name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteGrey,
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/svg/add-comment.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteGrey,
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/svg/order-gift.svg'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.readOnly != true
                          ? () {
                              decrease();
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: orderColor),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: SvgPicture.asset('assets/svg/minus.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 90,
                      child: FormTextField(
                        readOnly: widget.readOnly!,
                        onComplete: () {
                          removeCart(
                              int.tryParse(quantityController.text) ?? 0);
                        },
                        onChanged: (value) {
                          setState(() {
                            widget.data.quantity =
                                int.tryParse(quantityController.text) ?? 0;
                            if (widget.data.quantity != 0 &&
                                widget.isPackage == true) {
                              orderCart(widget.data, widget.data.quantity!);
                            }
                            widget.listenController?.changeVariable('form');
                          });
                        },
                        fontSize: 18,
                        controller: quantityController,
                        inputType: TextInputType.number,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 15,
                          ),
                          hintText: '0',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 5),
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
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.readOnly == false
                          ? () {
                              increase();
                            }
                          : null,
                      child: Container(
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          color: orderColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data.quantity == null || widget.data.quantity == 0
                    ? const Text(
                        '... ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Expanded(
                        child: Text(
                          '${widget.data.quantity! * widget.data.unitConvertValue!} ширхэг',
                          style: const TextStyle(
                            color: grey2,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                widget.data.quantity != null && widget.data.price != null
                    ? Expanded(
                        child: Text(
                          '${Utils().formatCurrency((widget.data.price! * widget.data.quantity!).toString())}₮',
                          style: const TextStyle(
                            color: grey2,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    : const Text(''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
