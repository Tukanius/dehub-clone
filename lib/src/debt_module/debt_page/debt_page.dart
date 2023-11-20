import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './tabs/dashboard_tab/dashboard_tab.dart';

class DebtPage extends StatefulWidget {
  static const routeName = '/DebtPage';
  const DebtPage({Key? key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  int selectedIndex = 1;
  static const List<Widget> currentPages = [
    SizedBox(),
    DashBoardTab(),
    Text('3'),
    Text('4'),
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: CustomBackButton(color: debtColor),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
            decoration: BoxDecoration(
              color: Color(0xff767680).withOpacity(0.12),
              borderRadius: BorderRadius.circular(100),
            ),
            child: SvgPicture.asset(
              'assets/svg/grid.svg',
              colorFilter: ColorFilter.mode(debtColor, BlendMode.srcIn),
            ),
          )
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: debtColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: debtColor,
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
                      color: selectedIndex == 0 ? debtColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : debtColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  selectedIndex != 0
                      ? Text(
                          'Нүүр',
                          style: TextStyle(color: debtColor, fontSize: 12),
                        )
                      : SizedBox(),
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
                    color: selectedIndex == 1 ? debtColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : debtColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: debtColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? debtColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/inbox.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : debtColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: debtColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? debtColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/sent.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : debtColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: debtColor, fontSize: 12),
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
