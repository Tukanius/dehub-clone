import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';

class OrderProductCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? onCloseClick;
  final Order? data;
  final bool? readOnly;
  final bool? isTap;
  final ListenController? listenController;
  const OrderProductCard({
    this.onCloseClick,
    this.listenController,
    this.readOnly,
    this.isTap,
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard>
    with AfterLayoutMixin {
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  int newValue = 0;

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      if (widget.data?.quantity != null) {
        quantityController.text = widget.data!.quantity.toString();
      } else {
        quantityController.text = "0";
      }
    });
  }

  decrease() {
    if (int.parse(quantityController.text) > 0) {
      setState(() {
        int currentValue = int.tryParse(quantityController.text) ?? 0;
        newValue = currentValue - 1;
        quantityController.text = newValue.toString();
        widget.data?.quantity = int.parse(quantityController.text.toString());
        widget.listenController?.changeVariable('decrease');
      });
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  increase() {
    setState(() {
      int currentValue = int.tryParse(quantityController.text) ?? 0;
      newValue = currentValue + 1;
      quantityController.text = newValue.toString();
      widget.data?.quantity = int.parse(quantityController.text.toString());
      widget.listenController?.changeVariable('increase');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.isTap == true ? orderColor : transparent,
          ),
          color: white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data?.image != null
                    ? Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage('${widget.data?.image}'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
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
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              spreadRadius: 3,
                              color: lightGrey,
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data?.nameMon != null
                          ? Text(
                              '${widget.data?.nameMon}',
                              style: TextStyle(
                                color: dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              '${widget.data?.name}',
                              style: TextStyle(
                                color: dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          style:
                              TextStyle(color: dark, fontFamily: 'Montserrat'),
                          children: [
                            widget.data?.skuCode != null
                                ? TextSpan(text: "${widget.data?.skuCode}, ")
                                : TextSpan(),
                            widget.data?.brand != null
                                ? TextSpan(text: "${widget.data?.brand}, ")
                                : TextSpan(),
                            widget.data?.category != null
                                ? TextSpan(text: "${widget.data?.category}, ")
                                : TextSpan(),
                            widget.data?.optionValues != null
                                ? TextSpan(
                                    text:
                                        "${widget.data?.optionValues?.map((e) => e.name).join(', ')}",
                                  )
                                : TextSpan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: widget.onCloseClick,
                  child: SvgPicture.asset(
                    'assets/svg/close.svg',
                    colorFilter: ColorFilter.mode(grey3, BlendMode.srcIn),
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Нэгж',
                      style: TextStyle(
                        color: coolGrey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.data?.unit}',
                      style: TextStyle(
                        color: orderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          'Солих',
                          style: TextStyle(
                            color: orderColor,
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: orderColor,
                          size: 12,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
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
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.data?.price}₮',
                      style: TextStyle(
                        color: orderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '1 ш',
                      style: TextStyle(
                        color: dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Хөнгөлөлт',
                      style: TextStyle(
                        color: coolGrey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '0₮',
                      style: TextStyle(
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
                        color: Color(0xffEBFAFA),
                      ),
                      child: Text(
                        'дүн',
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
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteGrey,
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/svg/add-comment.svg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
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
                      onTap: () {
                        if (widget.readOnly != true) {
                          decrease();
                        }
                      },
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
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 90,
                      child: FormTextField(
                        readOnly: widget.readOnly!,
                        onChanged: (value) {
                          setState(() {
                            widget.data?.quantity =
                                int.tryParse(quantityController.text) ?? 0;
                          });
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
                              vertical: 6, horizontal: 5),
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
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.readOnly != true) {
                          increase();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          color: orderColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Icon(
                          Icons.add,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data?.quantity == null || widget.data?.quantity == 0
                    ? Text(
                        '... ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        '${widget.data?.quantity} ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                widget.data?.quantity != null && widget.data?.price != null
                    ? Text(
                        '${Utils().formatCurrency((widget.data!.price! * widget.data!.quantity!).toString())}₮',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Text(''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
