import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class AddProductCard extends StatefulWidget {
  final Color? color;
  final Invoice? data;
  const AddProductCard({
    this.color,
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> with AfterLayoutMixin {
  int price = 9500;
  int amount = 1000;
  int percent = 5;
  int _count = 00;
  String? discount;

  @override
  afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Image(
                      image: NetworkImage(
                          'https://www.apudairy.mn/wp-content/uploads/2021/09/d-suu-1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Гүзээлзгэнэтэй иогурт',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'SKU 32165456, Brand Name, 250 гр, савлагааны нэр боөрсорыбх',
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
                ],
              ),
              SvgPicture.asset(
                'images/close.svg',
                color: grey3,
                height: 20,
                width: 20,
              )
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
                          '${price} ₮',
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '5 кг',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 20,
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
                            color: Color(0xff8181A5),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '5%',
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_count > 0) {
                            _count--;
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
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          const EdgeInsets.only(right: 5, top: 8, bottom: 11),
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0xffF2F3F7),
                        border: Border.all(
                          color: Color(0xffD9DCDE),
                        ),
                      ),
                      child: Text(
                        '${_count}',
                        style: TextStyle(color: grey3, fontSize: 20),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _count++;
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
                ),
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
                '${price * _count} ₮',
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
    );
  }
}
