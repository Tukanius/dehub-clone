import 'package:dehub/components/bank_account_card/bank_account_card.dart';
import 'package:dehub/screens/account_info_page/account_info_page.dart';
import 'package:dehub/screens/link_account_page/link_account_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Golomt extends StatefulWidget {
  const Golomt({Key? key}) : super(key: key);

  @override
  _GolomtState createState() => _GolomtState();
}

class _GolomtState extends State<Golomt> {
  List<BankAccountCard> bankcards = [
    BankAccountCard(),
    BankAccountCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Холбосон дансаар',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LinkAccountPage.routeName);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: neonGreen,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.add,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CarouselSlider(
                      items: bankcards,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: neonGreen.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: neonGreen,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        child: SvgPicture.asset(
                          'images/nehemjleh.svg',
                          color: white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Хүлээгдэж буй',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: neonGreen),
                        ),
                        Text(
                          '₮10.203.000.00',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
