import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/profile/information/screens/page1.dart';
import 'package:dehub/screens/profile/information/screens/page2.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PartnerInfo1 extends StatefulWidget {
  static const routeName = '/PartnerInfo1';
  const PartnerInfo1({Key? key}) : super(key: key);

  @override
  State<PartnerInfo1> createState() => _PartnerInfo1State();
}

class _PartnerInfo1State extends State<PartnerInfo1> {
  int currentIndex = 1;
  Partner partner = Partner();

  pageChange() {
    switch (currentIndex) {
      case 1:
        return Page1();
      case 2:
        return Page2();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15, top: 35),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      '${partner.partner?.businessName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${partner.user?.currentBusiness?.profileNameEng}',
                      style: TextStyle(
                        fontSize: 16,
                        color: grey3,
                      ),
                    ),
                  ],
                ),
              ),
              pageChange(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
                child: currentIndex == 1
                    ? Container(
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
                                  color: buttonColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/svg/arrow_forward.svg',
                                color: buttonColor,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 50, left: 16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/arrow_back.svg',
                                color: buttonColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Өмнөх',
                                style: TextStyle(
                                  color: buttonColor,
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
                // : Container(
                //     margin: const EdgeInsets.only(bottom: 50),
                //     width: MediaQuery.of(context).size.width,
                //     child: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           currentIndex = 2;
                //         });
                //       },
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Text(
                //             'Дараах',
                //             style: TextStyle(
                //               color: buttonColor,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           SvgPicture.asset(
                //             'assets/svg/arrow_forward.svg',
                //             color: buttonColor,
                //           ),
                //           SizedBox(
                //             width: 16,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                ),
          ),
        ],
      ),
    );
  }
}
