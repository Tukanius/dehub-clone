import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderProductCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? onCloseClick;
  final Order? data;
  const OrderProductCard({
    this.onCloseClick,
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
  int count = 0;

  decrease() {
    setState(() {
      if (count > 0) {
        setState(() {
          count--;
        });
      }
      widget.data?.quantity = count;
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
                Container(
                  width: MediaQuery.of(context).size.width - 120,
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
                      Text(
                        'SKU ${widget.data?.skuCode}, ${widget.data?.brand},${widget.data?.category ?? widget.data?.category}, ${widget.data?.optionValues?.map((e) => e.name).join()}',
                        style: TextStyle(color: dark),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: widget.onCloseClick,
                  child: SvgPicture.asset(
                    'images/close.svg',
                    color: grey3,
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Үлдэгдэл',
                      style: TextStyle(
                        color: coolGrey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/zahialga.svg',
                          color: black,
                          height: 9,
                          width: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.data?.onDeliveryQuantity}',
                          style: TextStyle(
                            color: orderColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/ware-house.svg',
                          color: black,
                          height: 9,
                          width: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.data?.warehouseQuantity}',
                          style: TextStyle(
                            color: dark,
                            fontSize: 12,
                          ),
                        ),
                      ],
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
                        child: SvgPicture.asset('images/add-comment.svg'),
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
                        child: SvgPicture.asset('images/order-gift.svg'),
                      ),
                    ),
                  ],
                ),
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
                    Container(
                        padding: const EdgeInsets.only(right: 5),
                        alignment: Alignment.centerRight,
                        height: 36,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Color(0xffF2F3F7),
                          border: Border.all(
                            color: Color(0xffD9DCDE),
                          ),
                        ),
                        child: widget.data?.quantity != null
                            ? Text(
                                '${widget.data?.quantity}',
                                style: TextStyle(
                                  color: grey3,
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                '0',
                                style: TextStyle(
                                  color: grey3,
                                  fontSize: 20,
                                ),
                              )),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          count++;
                          widget.data?.quantity = count;
                        });
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
                count == 0 || widget.data?.quantity == null
                    ? Text(
                        '... ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        '${count} ширхэг',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                widget.data?.quantity != null
                    ? Text(
                        '${widget.data!.price! * widget.data!.quantity!}₮',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        '${widget.data!.price! * count}₮',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
