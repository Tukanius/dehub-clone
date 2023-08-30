import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Shirhegeer extends StatefulWidget {
  static const routeName = '/Shirhegeer';
  const Shirhegeer({super.key});

  @override
  State<Shirhegeer> createState() => _ShirhegeerState();
}

class _ShirhegeerState extends State<Shirhegeer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 2; i++)
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
                  GestureDetector(
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
                        GestureDetector(
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
                        GestureDetector(
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
