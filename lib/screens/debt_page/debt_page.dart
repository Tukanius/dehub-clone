import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/debt_page/tabs/home_page_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DebtPage extends StatefulWidget {
  static const routeName = 'DebtPage';
  const DebtPage({Key? key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
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
                  color: debtColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(color: debtColor, fontSize: 17),
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
            child: SvgPicture.asset('images/grid.svg', color: debtColor),
          )
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedIconTheme: IconThemeData(color: debtColor),
        fixedColor: debtColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: debtColor,
            ),
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/dashboard.svg',
              color: debtColor,
            ),
            label: 'Дашбоард',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/partners.svg',
              color: debtColor,
            ),
            label: 'Хэрэглэгч',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/bag.svg',
              color: debtColor,
            ),
            label: 'Эрх, роль',
          ),
        ],
      ),
    );
  }
}
