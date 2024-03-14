import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import './tabs/settlement_tab/settlement_tab.dart';
import 'package:dehub/src/invoice_module/main_page/tabs/network_settlement_tab/network_statement_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/invoice_module/main_page/tabs/dashboard_tab/dashboard_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class Invoicepage extends StatefulWidget {
  static const routeName = '/Invoicepage';
  const Invoicepage({super.key});

  @override
  State<Invoicepage> createState() => _InvoicepageState();
}

class _InvoicepageState extends State<Invoicepage> with AfterLayoutMixin {
  int selectedIndex = 1;
  bool isLoading = true;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false).init(true);
    await Provider.of<UserProvider>(context, listen: false).invoice(true);
    setState(() {
      isLoading = false;
    });
  }

  static const List<Widget> currentPages = [
    SizedBox(),
    DashBoardTab(),
    NetworkSettlementTab(),
    SettlementTab(),
  ];

  void ontappedItem(int index) {
    if (index == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: selectedIndex != 2 ? 100 : 56,
        elevation: 0,
        backgroundColor: selectedIndex == 2 ? white : backgroundColor,
        surfaceTintColor: selectedIndex == 2 ? white : backgroundColor,
        leading: selectedIndex != 2
            ? const CustomBackButton(
                color: invoiceColor,
              )
            : null,
        iconTheme: const IconThemeData(color: invoiceColor),
        title: selectedIndex == 0
            ? FormTextField(
                inputType: TextInputType.text,
                color: const Color(0xff767680).withOpacity(0.12),
                name: 'search',
                prefixIcon: const Icon(Icons.search),
                hintText: 'Партнер нэрээр хайх',
              )
            : selectedIndex == 2
                ? user.currentBusiness?.type == "SUPPLIER"
                    ? const Text(
                        'Харилцагчийн тооцоо',
                        style: TextStyle(
                          color: invoiceColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : const Text(
                        'Нийлүүлэгчийн тооцоо',
                        style: TextStyle(
                          color: invoiceColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                : const SizedBox(),
        actions: [
          selectedIndex == 0
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xff767680).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/grid.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex != 3 ? invoiceColor : white,
                        BlendMode.srcIn),
                  ),
                )
              : selectedIndex == 3
                  ? const AddButton(
                      color: white,
                      addColor: invoiceColor,
                    )
                  : const SizedBox(),
        ],
      ),
      body: isLoading == true
          ? const SizedBox()
          : Container(
              child: currentPages.elementAt(selectedIndex),
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: invoiceColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: invoiceColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedIndex == 0 ? invoiceColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : invoiceColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  if (selectedIndex != 0)
                    const Text(
                      'Нүүр',
                      style: TextStyle(color: invoiceColor, fontSize: 12),
                    ),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 1 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : invoiceColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 1)
                  const Text(
                    'Дашбоард',
                    style: TextStyle(color: invoiceColor, fontSize: 12),
                  ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 2 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/user-dollar.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : invoiceColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 2)
                  const Text(
                    'Тооцоо',
                    style: TextStyle(color: invoiceColor, fontSize: 12),
                  ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 3 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/coins.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : invoiceColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 3)
                  const Text(
                    'Тооцоо нийлэх',
                    style: TextStyle(color: invoiceColor, fontSize: 12),
                  ),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
