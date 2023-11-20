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
              'Бараа удирдлага',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/grid1.svg',
                          colorFilter:
                              ColorFilter.mode(paymentColor, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Барааны жагсаалт',
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
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/push.svg',
                          colorFilter:
                              ColorFilter.mode(paymentColor, BlendMode.srcIn),
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
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/bag.svg',
                          colorFilter:
                              ColorFilter.mode(paymentColor, BlendMode.srcIn),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/map.svg',
                          colorFilter:
                              ColorFilter.mode(paymentColor, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Хөнгөлөлт, урамшуулал',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500),
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
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/map.svg',
                          colorFilter:
                              ColorFilter.mode(paymentColor, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Лавлах мэдээлэл',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
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
