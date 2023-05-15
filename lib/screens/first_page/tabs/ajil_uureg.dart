import 'package:dehub/screens/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/screens/debt_page/debt_page.dart';
import 'package:dehub/screens/financing_page/financing_page.dart';
import 'package:dehub/screens/main_invoice_page/invoice_page.dart';
import 'package:dehub/screens/order_page/order_page.dart';
import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/screens/network_page/network_page.dart';
import 'package:dehub/screens/partner_page/partner_page.dart';
import 'package:dehub/screens/product_page/product_page.dart';
import 'package:dehub/screens/user_management_page/user_management_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AjilUureg extends StatefulWidget {
  const AjilUureg({Key? key}) : super(key: key);

  @override
  _AjilUuregState createState() => _AjilUuregState();
}

class _AjilUuregState extends State<AjilUureg> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ажил үүрэг'),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MainInvoicePage.routeName);
                        // Navigator.of(context).pushNamed(MainPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/nehemjleh.svg',
                            color: invoiceColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Нэхэмжлэх',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(OrderPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/zahialga.svg',
                            color: orderColor,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Захиалга',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pushNamed(PaymentPage.routeName);
                        Navigator.of(context)
                            .pushNamed(AddBankAccountPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/tolbor_tootsoo.svg',
                            color: paymentColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Төлбөр тооцоо',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FinancingPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/sanhuujilt.svg',
                            color: financingColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Санхүүжилт',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(DebtPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/avlaga_uglug.svg',
                            color: debtColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Авлага, өглөг',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ProductPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/baraa.svg',
                            color: productColor,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Бараа, материал',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(NetworkPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/network.svg',
                            color: networkColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Network',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(PartnerPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/partner.svg',
                            color: partnerColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Партнер',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(UserMangementPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/hereglegch.svg',
                            color: userColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Хэрэглэгч',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Сануулга мэдэгдэл',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
