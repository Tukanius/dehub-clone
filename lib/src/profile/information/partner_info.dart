import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/profile/information/screens/page1.dart';
import 'package:dehub/src/profile/information/screens/page2.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PartnerInfo extends StatefulWidget {
  const PartnerInfo({super.key});

  @override
  State<PartnerInfo> createState() => _PartnerInfoState();
}

class _PartnerInfoState extends State<PartnerInfo> {
  int currentIndex = 1;
  Partner partner = Partner();

  pageChange() {
    switch (currentIndex) {
      case 1:
        return const Page1();
      case 2:
        return const Page2();
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${partner.user?.currentBusiness?.profileNameEng}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: grey3,
                      ),
                    ),
                  ],
                ),
              ),
              pageChange(),
              const SizedBox(
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
                        child: Container(
                          color: transparent,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 1.8),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Дараах',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/svg/arrow_forward.svg',
                                colorFilter: const ColorFilter.mode(
                                    buttonColor, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
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
                        child: Container(
                          color: transparent,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/arrow_back.svg',
                                colorFilter: const ColorFilter.mode(
                                    buttonColor, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Өмнөх',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
