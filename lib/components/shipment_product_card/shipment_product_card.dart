import 'package:dehub/models/order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';

class ShipmentProductCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? onCloseClick;
  final Order? data;
  final Function() approveButtonClick;
  final String? lineConfirmText;
  const ShipmentProductCard({
    this.onCloseClick,
    this.lineConfirmText,
    required this.approveButtonClick,
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<ShipmentProductCard> createState() => _ShipmentProductCardState();
}

class _ShipmentProductCardState extends State<ShipmentProductCard>
    with AfterLayoutMixin {
  int count = 0;
  String quantity = '0';
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  TextEditingController quantityController = TextEditingController();
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      quantityController.text = widget.data!.quantity.toString();
    });
  }

  decrease() {
    setState(() {
      int currentValue = int.tryParse(quantityController.text) ?? 0;
      int newValue = currentValue - 1;
      quantityController.text = newValue.toString();
    });
  }

  increase() {
    setState(() {
      int currentValue = int.tryParse(quantityController.text) ?? 0;
      int newValue = currentValue + 1;
      quantityController.text = newValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: white,
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
                          ),
                        ),
                      )
                    : Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: black,
                        ),
                      ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
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
                              TextStyle(color: dark, fontFamily: "Montserrat"),
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
                                        "${widget.data?.optionValues?.map((e) => e.name).join(', ')}")
                                : TextSpan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
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
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Тоо ширхэг',
                        style: TextStyle(
                          color: coolGrey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          color: orderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${widget.data?.unitConvertValue} ш',
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийт дүн',
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
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.data?.isConfirmed == false) {
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
                        onChanged: (p0) {
                          setState(() {
                            widget.data?.quantity =
                                int.parse(quantityController.text);
                          });
                        },
                        readOnly:
                            widget.data?.isConfirmed == false ? false : true,
                        controller: quantityController,
                        fontSize: 18,
                        inputType: TextInputType.number,
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
                        if (widget.data?.isConfirmed == false) {
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
                ),
                GestureDetector(
                  onTap: widget.data?.isConfirmed == true
                      ? () {}
                      : () {
                          widget.approveButtonClick();
                        },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                      border: Border.all(
                        color: widget.data?.isConfirmed == true
                            ? orderColor.withOpacity(0.3)
                            : orderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calculator.svg',
                          colorFilter: ColorFilter.mode(
                              widget.data?.isConfirmed == true
                                  ? orderColor.withOpacity(0.3)
                                  : orderColor,
                              BlendMode.srcIn),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        isSubmit == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: orderColor,
                                    ),
                                  ),
                                ),
                              )
                            : widget.lineConfirmText == null
                                ? Text(
                                    'Зөв байна',
                                    style: TextStyle(
                                      color: widget.data?.isConfirmed == true
                                          ? orderColor.withOpacity(0.3)
                                          : orderColor,
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    '${widget.lineConfirmText}',
                                    style: TextStyle(
                                      color: widget.data?.isConfirmed == true
                                          ? orderColor.withOpacity(0.3)
                                          : orderColor,
                                      fontSize: 18,
                                    ),
                                  ),
                      ],
                    ),
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
