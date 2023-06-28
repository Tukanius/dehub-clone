import 'package:dehub/screens/user_management_page/tabs/home_page_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserMangementPage extends StatefulWidget {
  static const routeName = '/UserMangementPage';
  const UserMangementPage({Key? key}) : super(key: key);

  @override
  _UserMangementPageState createState() => _UserMangementPageState();
}

class _UserMangementPageState extends State<UserMangementPage> {
  int selectedIndex = 0;
  static const List<Widget> currentPages = [
    HomePageTab(),
    Text('2'),
    Text('3'),
    Text('4'),
  ];

  void ontappedItem(int index) {
    setState(() {
      selectedIndex = index;
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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: userColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(color: userColor, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
            decoration: BoxDecoration(
              color: Color(0xff767680).withOpacity(0.12),
              borderRadius: BorderRadius.circular(100),
            ),
            child: SvgPicture.asset('images/grid.svg', color: userColor),
          )
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
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
                    'images/home.svg',
                    color: selectedIndex == 0 ? white : userColor,
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/dashboard.svg',
                    color: selectedIndex == 1 ? white : userColor,
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/inbox.svg',
                    color: selectedIndex == 2 ? white : userColor,
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: userColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? userColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/sent.svg',
                    color: selectedIndex == 3 ? white : userColor,
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: userColor, fontSize: 12),
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
