import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ShipmentProductCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? onCloseClick;
  final Order? data;
  final Function()? approveButtonClick;
  const ShipmentProductCard({
    this.onCloseClick,
    this.approveButtonClick,
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<ShipmentProductCard> createState() => _ShipmentProductCardState();
}

class _ShipmentProductCardState extends State<ShipmentProductCard> {
  int count = 0;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  TextEditingController quantityController = TextEditingController();

  decrease() {
    setState(() {
      if (count > 0) {
        setState(() {
          count--;
          widget.data?.quantity = int.parse(quantityController.text);
        });
      }
    });
    print(widget.data?.quantity);
  }

  increase() {
    setState(() {
      count++;
      // fbKey.currentState?.fields['quantity']?.value = count.toString();
      widget.data?.quantity = fbKey.currentState?.fields['quantity']?.value;
    });
    print(fbKey.currentState?.fields['quantity']!.value);
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
                        '${widget.data?.nameMon}',
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
                          style: TextStyle(color: dark),
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
                      '0',
                      style: TextStyle(
                        color: orderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '50 ш',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data?.quantity == null
                    ? Text(
                        '... ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        '${fbKey.currentState?.fields['quantity']?.value} ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                widget.data?.quantity != null && widget.data?.price != null
                    ? Text(
                        '${widget.data!.price! * widget.data!.quantity!}₮',
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
                        decrease();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: orderColor),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: SvgPicture.asset('images/minus.svg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FormBuilder(
                      key: fbKey,
                      child: SizedBox(
                        width: 90,
                        child: FormTextField(
                          onChanged: (p0) {
                            setState(() {
                              widget.data?.quantity =
                                  fbKey.currentState?.fields['quantity']?.value;
                              print(widget.data?.quantity);
                            });
                          },
                          initialValue: widget.data!.quantity.toString(),
                          fontSize: 18,
                          inputType: TextInputType.number,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            hintText: '00',
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        increase();
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
                  onTap: widget.approveButtonClick,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                      border: Border.all(
                        color: orderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('images/calculator.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Зөв байна',
                          style: TextStyle(
                            color: orderColor,
                            fontSize: 18,
                          ),
                        )
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
