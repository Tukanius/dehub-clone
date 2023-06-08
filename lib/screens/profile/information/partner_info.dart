import 'package:dehub/screens/profile/information/screens/page1.dart';
import 'package:dehub/screens/profile/information/screens/page2.dart';
import 'package:dehub/screens/profile/information/screens/page3.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PartnerInfo1 extends StatefulWidget {
  static const routeName = '/PartnerInfo1';
  const PartnerInfo1({super.key});

  @override
  State<PartnerInfo1> createState() => _PartnerInfo1State();
}

class _PartnerInfo1State extends State<PartnerInfo1> {
  int currentIndex = 1;

  pageChange() {
    switch (currentIndex) {
      case 1:
        return Page1();
      case 2:
        return Page2();
      case 3:
        return Page3();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                pageChange(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                child: currentIndex == 2
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 1;
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    SvgPicture.asset(
                                      'images/arrow_back.svg',
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Өмнөх',
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 3;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Дараах',
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      'images/arrow_forward.svg',
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : currentIndex == 3
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 50, left: 16),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = 2;
                                });
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'images/arrow_back.svg',
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Өмнөх',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(bottom: 50),
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = 2;
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Дараах',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    'images/arrow_forward.svg',
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
