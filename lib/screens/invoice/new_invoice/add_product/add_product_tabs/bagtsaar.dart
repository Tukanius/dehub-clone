import 'package:dehub/components/add_product_card/add_product_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bagtsaar extends StatefulWidget {
  static const routeName = '/bagtsaar';
  const Bagtsaar({super.key});

  @override
  State<Bagtsaar> createState() => _BagtsaarState();
}

class _BagtsaarState extends State<Bagtsaar> {
  int price = 9500;
  int amount = 1000;
  int percent = 5;
  int _count = 00;
  String? discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++)
              AddProductCard(
                color: brownButtonColor,
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
