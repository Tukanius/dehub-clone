import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class AddProductCard extends StatefulWidget {
  final Function()? closeClick;
  final bool? hasCount;
  final Color? color;
  final Invoice? data;
  final Function()? onClick;
  final bool? isCheck;
  final int? index;
  const AddProductCard({
    this.hasCount,
    this.closeClick,
    this.index,
    this.isCheck,
    this.onClick,
    this.color,
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> with AfterLayoutMixin {
  int _count = 00;
  String? discount;
  bool isCheck = false;

  @override
  afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: widget.data?.image != null
                          ? Image(
                              image: NetworkImage('${widget.data?.image}'),
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
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.data?.nameMon}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 240,
                            child: Text(
                              '${widget.data?.skuCode}, ${widget.data?.barCode}, ${widget.data?.erpCode}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                widget.isCheck == false
                    ? GestureDetector(
                        onTap: widget.closeClick,
                        child: SvgPicture.asset(
                          'images/close.svg',
                          color: grey3,
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
            Container(
              child: Row(
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
                            '${Utils().formatCurrency(widget.data?.price.toString())}₮',
                            style: TextStyle(
                              color: widget.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${widget.data?.unitName}',
                            style: TextStyle(
                              color: grey2,
                              fontSize: 18,
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
                          Text(
                            '0%',
                            style: TextStyle(
                              color: widget.color,
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
                            child: Text(
                              'хувиар',
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
                  widget.hasCount == true
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_count > 0) {
                                    _count--;
                                    widget.data?.quantity = _count.toDouble();
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 13),
                                decoration: BoxDecoration(
                                  border: Border.all(color: widget.color!),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: widget.color,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.only(
                                  right: 5, top: 8, bottom: 11),
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Color(0xffF2F3F7),
                                border: Border.all(
                                  color: Color(0xffD9DCDE),
                                ),
                              ),
                              child: widget.data?.quantity == null
                                  ? Text(
                                      '0',
                                      style:
                                          TextStyle(color: grey3, fontSize: 20),
                                      textAlign: TextAlign.end,
                                    )
                                  : Text(
                                      '${widget.data?.quantity?.toInt()}',
                                      style:
                                          TextStyle(color: grey3, fontSize: 20),
                                      textAlign: TextAlign.end,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _count++;
                                  widget.data?.quantity = _count.toDouble();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 13),
                                decoration: BoxDecoration(
                                  color: widget.color,
                                  border: Border.all(color: widget.color!),
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
                      : SizedBox(),
                ],
              ),
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
                Text(
                  '${double.parse(_count.toString()) * widget.data!.price!} ₮',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: grey2,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
