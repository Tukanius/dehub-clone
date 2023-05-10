import 'package:dehub/screens/invoice/invoice_page.dart';
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
              'Нэхэмжлэх удирдлага',
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
                    Navigator.of(context).pushNamed(InvoicePage.routeName);
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
                            color: invoiceColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'images/take_invoice.svg',
                            color: invoiceColor,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Манай авах- нэхэмжлэл',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
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
                  width: 100,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: invoiceColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/give_invoice.svg',
                          color: invoiceColor,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Манай төлөх- нэхэмжлэл',
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
                          color: invoiceColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/bag.svg',
                          color: invoiceColor,
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
                          color: invoiceColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/map.svg',
                          color: invoiceColor,
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
                          color: invoiceColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'images/map.svg',
                          color: invoiceColor,
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
