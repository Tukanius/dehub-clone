import 'package:dehub/screens/profile/information/partner_info1.dart';
import 'package:dehub/screens/profile/information/partner_info2.dart';
import 'package:dehub/screens/profile/information/screens/page1.dart';
import 'package:dehub/screens/profile/information/screens/page2.dart';
import 'package:dehub/screens/profile/information/screens/page3.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

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
      child: Stack(
        children: [
          Column(
            children: [
              pageChange(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              child: currentIndex == 2
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex = 1;
                                });
                              },
                              child: Text(
                                'Өмнөх',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: white,
                                side: BorderSide(
                                  color: buttonColor,
                                ),
                                shadowColor: transparent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex = 3;
                                });
                              },
                              child: Text(
                                'Дараах',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shadowColor: transparent,
                                backgroundColor: buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : currentIndex == 3
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // margin: const EdgeInsets.only(left: 15),
                                child: CustomButton(
                                  labelText: "Үргэлжлүүлэх",
                                  onClick: () {
                                    setState(() {
                                      currentIndex = 4;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            labelText: "Үргэлжлүүлэх",
                            onClick: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
