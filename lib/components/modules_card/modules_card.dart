import 'package:dehub/models/partner.dart';
import 'package:dehub/screens/auth/financing_login.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/screens/debt_page/debt_page.dart';
// import 'package:dehub/screens/financing_page/financing_page.dart';
import 'package:dehub/screens/main_invoice_page/invoice_page.dart';
import 'package:dehub/screens/network_page/network_page.dart';
import 'package:dehub/screens/order_page/order_page.dart';
import 'package:dehub/screens/partner_page/partner_page.dart';
import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/screens/product_page/product_page.dart';
import 'package:dehub/screens/user_management_page/user_management_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModulesCard extends StatefulWidget {
  final Partner? partner;
  const ModulesCard({Key? key, this.partner}) : super(key: key);

  @override
  State<ModulesCard> createState() => _ModulesCardState();
}

class _ModulesCardState extends State<ModulesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
      ),
      margin: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GridView.count(
            childAspectRatio: 1 / .75,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness?.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness?.type == "BUYER") {
                    Navigator.of(context).pushNamed(MainInvoicePage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: invoiceColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/nehemjleh.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Нэхэмжлэх',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(OrderPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: orderColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/zahialga.svg',
                        color: buttonColor,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(PaymentPage.routeName);
                  }
                  // Navigator.of(context)
                  //     .pushNamed(AddBankAccountPage.routeName);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: paymentColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/tolbor_tootsoo.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(FinancingPage.routeName);
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(FinancingLogin.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: financingColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/sanhuujilt.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(DebtPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: debtColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/avlaga_uglug.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(ProductPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: productColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/baraa.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Бараа, ажил',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness!.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness!.type == "BUYER") {
                    Navigator.of(context).pushNamed(NetworkPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: networkColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/network.svg',
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Бизнес нетворк',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness?.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness?.type == "BUYER") {
                  } else {
                    Navigator.of(context).pushNamed(PartnerPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? partnerColor.withOpacity(0.1)
                            : partnerColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/partner.svg',
                        color: widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? partnerColor.withOpacity(0.3)
                            : buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Манай бизнес',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.partner?.user?.currentBusiness?.type ==
                          'SUPPLIER' ||
                      widget.partner?.user?.currentBusiness?.type == "BUYER") {
                  } else {
                    Navigator.of(context)
                        .pushNamed(UserMangementPage.routeName);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? userColor.withOpacity(0.1)
                            : userColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'images/hereglegch.svg',
                        color: widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? userColor.withOpacity(0.3)
                            : buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Хэрэглэгчид',
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
    );
  }
}
