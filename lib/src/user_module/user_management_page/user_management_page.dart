import 'package:after_layout/after_layout.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/financing/financing_tab.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/rule/rule_tab.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/setting/setting_tab.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/users/user_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserMangementPage extends StatefulWidget {
  static const routeName = '/UserMangementPage';
  const UserMangementPage({super.key});

  @override
  UserMangementPageState createState() => UserMangementPageState();
}

class UserMangementPageState extends State<UserMangementPage>
    with AfterLayoutMixin {
  int selectedIndex = 1;
  bool isLoading = true;
  static const List<Widget> currentPages = [
    SettingTab(),
    UsersTab(),
    RuleTab(),
    FinancingTab(),
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
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false).userInit(false);
    await Provider.of<UserProvider>(context, listen: false).userMe(false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: selectedIndex != 1
          ? AppBar(
              leadingWidth: 100,
              elevation: 0,
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
              leading: const CustomBackButton(color: userColor),
            )
          : null,
      body: isLoading == true
          ? const SizedBox()
          : currentPages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: userColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: userColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/home.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 0 ? white : userColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 0)
                  const Text(
                    'Нүүр',
                    style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/people.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : userColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 1)
                  const Text(
                    'Тохигоо',
                    style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/note.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : userColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 2)
                  const Text(
                    'Дүрэм',
                    style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/finance_review.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : userColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 3)
                  const Text(
                    'Санхүүжилт',
                    style: TextStyle(color: userColor, fontSize: 12),
                  )
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
