import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/payment_module/payment_page/tabs/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/utils/permission.dart';
import './tabs/dashboard_tab/dashboard_tab.dart';
import 'package:dehub/src/payment_module/screens/link_account_page/link_account_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/PaymentPage';
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with AfterLayoutMixin {
  int selectedIndex = 1;
  bool isLoading = true;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).payment(true);
    await Provider.of<GeneralProvider>(context, listen: false)
        .paymentInit(true);
    setState(() {
      isLoading = false;
    });
  }

  static const List<Widget> currentPages = [
    SizedBox(),
    DashboardTab(),
    AddBankAccountPage(),
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
    user = Provider.of<UserProvider>(context, listen: true).paymentMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        leading: const CustomBackButton(
          color: paymentColor,
        ),
        title: selectedIndex == 0
            ? FormTextField(
                inputType: TextInputType.text,
                color: const Color(0xff767680).withOpacity(0.12),
                name: 'search',
                prefixIcon: const Icon(Icons.search),
                hintText: 'Партнер нэрээр хайх',
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
                      selectedIndex != 3 ? paymentColor : white,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : selectedIndex == 2 &&
                      Permission().check(user, 'PAY_ACC', boolean: 'isCreate')
                  ? AddButton(
                      color: paymentColor,
                      addColor: white,
                      onClick: () {
                        Navigator.of(context)
                            .pushNamed(LinkAccountPage.routeName);
                      },
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
        unselectedItemColor: paymentColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: paymentColor,
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
                      color: selectedIndex == 0 ? paymentColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : paymentColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  if (selectedIndex != 0)
                    const Text(
                      'Нүүр',
                      style: TextStyle(color: paymentColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : paymentColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 1)
                  const Text(
                    'Дашбоард',
                    style: TextStyle(color: paymentColor, fontSize: 12),
                  )
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
                    color: selectedIndex == 2 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/wallet.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : paymentColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 2)
                  const Text(
                    'Данс',
                    style: TextStyle(color: paymentColor, fontSize: 12),
                  ),
              ],
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Column(
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: selectedIndex == 3 ? paymentColor : white,
          //         ),
          //         padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
          //         child: SvgPicture.asset(
          //           'assets/svg/grid2.svg',
          //           colorFilter: ColorFilter.mode(
          //               selectedIndex == 3 ? white : paymentColor,
          //               BlendMode.srcIn),
          //         ),
          //       ),
          //       if (selectedIndex != 3)
          //         const Text(
          //           'Тооцоо',
          //           style: TextStyle(color: paymentColor, fontSize: 12),
          //         ),
          //     ],
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
