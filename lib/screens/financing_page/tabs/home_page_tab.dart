import 'package:dehub/screens/avaible_funding_page/avaible_funding_page.dart';
import 'package:dehub/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Санхүүжилт удирдлага',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ReceivedFundingPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(10),
                    width: 90,
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: financingColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'images/camera.svg',
                            color: financingColor,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Авсан санхүүжилт',
                          style: TextStyle(
                              fontSize: 11.5, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 90,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: financingColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/push.svg',
                          color: financingColor,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Ажил, үйлчилгээ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 90,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: financingColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/bag.svg',
                          color: financingColor,
                        ),
                      ),
                      Text(
                        'Үнийн бодлого',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(FundingRequestPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(10),
                    width: 90,
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: financingColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'images/sanhuujiltS.svg',
                            color: financingColor,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Санхүүжилт хүсэлт',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AvaibleFundingPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(10),
                    width: 90,
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: financingColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'images/map.svg',
                            color: financingColor,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Боломжит нэхэмжлэл',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
