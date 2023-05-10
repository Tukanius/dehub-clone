import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class Bagtsaar extends StatefulWidget {
  static const routeName = '/bagtsaar';
  Bagtsaar({
    Key? key,
  }) : super(key: key);

  @override
  State<Bagtsaar> createState() => _BagtsaarState();
}

class _BagtsaarState extends State<Bagtsaar> with AfterLayoutMixin {
  bool isLoading = true;
  int price = 9500;
  int amount = 1000;
  int percent = 5;
  int _count = 00;
  String? discount;

  Invoice invoice = Invoice();

  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++)
              AddProductCard(
                color: invoiceColor,
              ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: white,
                        ),
                        Text(
                          'Сонгосонг нэмэх',
                          style: TextStyle(
                            fontSize: 10,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    child: VerticalDivider(
                      color: white,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.card_travel,
                                color: white,
                              ),
                              Text(
                                'Ердийн үнэ',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.card_giftcard_rounded,
                                color: white,
                              ),
                              Text(
                                'Урамшуулал',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
