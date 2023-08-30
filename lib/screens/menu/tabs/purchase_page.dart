import 'package:dehub/screens/menu/suppliers/suppliers_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PurchasePage extends StatefulWidget {
  static const routeName = '/purchasepage';
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text(
                  'Захиалга',
                  style: TextStyle(
                    color: grey2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('images/pie.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Тайлан, дашбоард',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: grey2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SuppliersPage.routeName);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('images/apartment.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ханган нийлүүлэгчид',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: grey2,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            color: grey3,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Худалдан авалтын захиалга',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: grey2,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('images/huleen_avsan.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Хүлээн авсан захиалгууд',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: grey2,
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
