import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:dehub/models/invoice.dart';

class InvoiceProductCard extends StatefulWidget {
  final Color? color;
  const InvoiceProductCard({
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<InvoiceProductCard> createState() => _InvoiceProductCardState();
}

class _InvoiceProductCardState extends State<InvoiceProductCard> {
  int price = 9500;
  int amount = 1000;
  int percent = 5;
  int _count = 00;
  String? discount;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 56,
                width: 56,
                child: Image(
                  image: AssetImage(
                    'images/map.jpg',
                  ),
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
                    width: MediaQuery.of(context).size.width * 0.67,
                    child: Text(
                      'SKU 32165456, Brand Name, 250 гр, савлагааны нэр боөрсорыбх',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Нэгж үнэ',
                      style: TextStyle(
                        color: Color(0xff8181A5),
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
                      '1 кг',
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
                      '${amount} ₮',
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
                            color: Color(0xff636E72).withOpacity(0.3),
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
                        )
                        // : Text(
                        //     'хувиар',
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w500,
                        //       color: grey2,
                        //     ),
                        //   ),
                        ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_count > 0) {
                        _count--;
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: widget.color!),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: widget.color,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.only(right: 5, top: 8, bottom: 11),
                  width: 80,
                  decoration: BoxDecoration(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 18),
                    decoration: BoxDecoration(
                      color: widget.color,
                      border: Border.all(color: widget.color!),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                  ),
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
                '${(price - amount) * _count} ₮',
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
