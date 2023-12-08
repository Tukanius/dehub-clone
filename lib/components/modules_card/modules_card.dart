import 'package:dehub/models/partner.dart';
import 'package:dehub/src/entry_point/finance_entry/finance_entry.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
// import 'package:dehub/src/debt_page/debt_page.dart';
import 'package:dehub/src/invoice_module/main_page/invoice_page.dart';
import 'package:dehub/src/network_module/network_page/network_page.dart';
import 'package:dehub/src/order_module/order_page/order_page.dart';
import 'package:dehub/src/partner_module/partner_page/partner_page.dart';
import 'package:dehub/src/payment_module/payment_page/payment_page.dart';
import 'package:dehub/src/product_module/product_page/product_page.dart';
import 'package:dehub/src/user_module/user_management_page/user_management_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModulesCard extends StatefulWidget {
  final Partner? partner;
  const ModulesCard({
    Key? key,
    this.partner,
  }) : super(key: key);

  @override
  State<ModulesCard> createState() => _ModulesCardState();
}

class _ModulesCardState extends State<ModulesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 150, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
      ),
      child: GridView.count(
        padding: const EdgeInsets.all(0),
        childAspectRatio: 1 / .75,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.partner?.user?.currentBusiness?.type == 'SUPPLIER' ||
                  widget.partner?.user?.currentBusiness?.type == "BUYER") {
                Navigator.of(context).pushNamed(Invoicepage.routeName);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: invoiceColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/nehemjleh.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Нэхэмжлэх',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: orderColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/zahialga.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
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
              if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: paymentColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/tolbor_tootsoo.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
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
              if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
                  widget.partner?.user?.currentBusiness!.type == "BUYER") {
                Navigator.of(context).pushNamed(FinanceEntry.routeName);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: financingColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/sanhuujilt.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
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
              if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: networkColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/network.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
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
              if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: productColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/baraa.svg',
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Бараа, ажил',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // if (widget.partner?.user?.currentBusiness!.type == 'SUPPLIER' ||
              //     widget.partner?.user?.currentBusiness!.type == "BUYER") {
              //   Navigator.of(context).pushNamed(DebtPage.routeName);
              // }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: debtColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/avlaga_uglug.svg',
                    colorFilter: ColorFilter.mode(
                        buttonColor.withOpacity(0.3), BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Авлага, өглөг',
                  style: TextStyle(
                    fontSize: 12,
                    color: black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.partner?.user?.currentBusiness?.type == 'SUPPLIER' ||
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                    'assets/svg/partner.svg',
                    colorFilter: ColorFilter.mode(
                        widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? partnerColor.withOpacity(0.3)
                            : buttonColor,
                        BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Манай бизнес',
                  style: TextStyle(
                    fontSize: 12,
                    color: black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.partner?.user?.currentBusiness?.type == 'SUPPLIER' ||
                  widget.partner?.user?.currentBusiness?.type == "BUYER") {
              } else {
                Navigator.of(context).pushNamed(UserMangementPage.routeName);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                    'assets/svg/hereglegch.svg',
                    colorFilter: ColorFilter.mode(
                        widget.partner?.user?.currentBusiness?.type ==
                                    'SUPPLIER' ||
                                widget.partner?.user?.currentBusiness?.type ==
                                    "BUYER"
                            ? userColor.withOpacity(0.3)
                            : buttonColor,
                        BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Хэрэглэгчид',
                  style: TextStyle(
                    fontSize: 12,
                    color: black.withOpacity(0.5),
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
