import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/user_management_page/tabs/home_page_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserMangementPage extends StatefulWidget {
  static const routeName = 'UserMangementPage';
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
        // selectedIconTheme: IconThemeData(color: userColor),
        fixedColor: userColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: userColor,
            ),
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/dashboard.svg',
              color: userColor,
            ),
            label: 'Дашбоард',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/partners.svg',
              color: userColor,
            ),
            label: 'Хэрэглэгч',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/bag.svg',
              color: userColor,
            ),
            label: 'Эрх, роль',
          ),
        ],
      ),
    );
  }
}
