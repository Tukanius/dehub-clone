// import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/finance_module/financing_page/tabs/dashboard_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class FinancingPage extends StatefulWidget {
  static const routeName = '/FinancingPage';
  const FinancingPage({super.key});

  @override
  State<FinancingPage> createState() => _FinancingPageState();
}

class _FinancingPageState extends State<FinancingPage> with AfterLayoutMixin {
  static const List<Widget> currentPages = [
    SizedBox(),
    DashBoardTab(),
    Text('1'),
    Text('2'),
  ];
  int selectedIndex = 1;
  bool isLoading = true;

  logout() async {
    await Provider.of<UserProvider>(context, listen: false).financeLogout();
    await Navigator.of(context).pushNamed(SplashPage.routeName);
  }

  void ontappedItem(int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false)
        .financeInit(false);
    await Provider.of<UserProvider>(context, listen: false).financeMe();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(SplashPage.routeName);
          },
          child: Container(
            color: transparent,
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: financingColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // selectedIndex == 1
          //     ?
          GestureDetector(
            onTap: () async {
              logout();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: financingColor, width: 0.5),
                shape: BoxShape.circle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: financingColor,
                    size: 12,
                  ),
                  Text(
                    'Гарах',
                    style: TextStyle(
                      color: financingColor,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          // : selectedIndex == 3
          //     ? AddButton(
          //         color: white,
          //         addColor: financingColor,
          //       )
          //     : SizedBox(),
        ],
      ),
      body: isLoading == true
          ? SizedBox()
          : Container(
              child: currentPages.elementAt(selectedIndex),
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: financingColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: financingColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? financingColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/home.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 0 ? white : financingColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: financingColor, fontSize: 12),
                      )
                    : SizedBox(),
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
                    color: selectedIndex == 1 ? financingColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : financingColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: financingColor, fontSize: 12),
                      )
                    : SizedBox(),
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
                    color: selectedIndex == 2 ? financingColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/finance_limit.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : financingColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Лимит',
                        style: TextStyle(color: financingColor, fontSize: 12),
                      )
                    : SizedBox(),
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
                    color: selectedIndex == 3 ? financingColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/calculation.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : financingColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Тооцоо',
                        style: TextStyle(color: financingColor, fontSize: 12),
                      )
                    : SizedBox(),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
