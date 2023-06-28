import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/order_page/tabs/dashboard_tab.dart';

class OrderPage extends StatefulWidget {
  static const routeName = '/OrderPage';
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

int selectedIndex = 0;

class _OrderPageState extends State<OrderPage> {
  static const List<Widget> currentPages = [
    Text('1'),
    DashboardTab(),
    Text('1'),
    Text('1'),
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
        backgroundColor: selectedIndex != 3 ? white : orderColor,
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
                  color: selectedIndex != 3 ? orderColor : white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                      color: selectedIndex != 3 ? orderColor : white,
                      fontSize: 17),
                ),
              ],
            ),
          ),
        ),
        title: selectedIndex == 0
            ? Container(
                child: FormTextField(
                  inputType: TextInputType.text,
                  color: Color(0xff767680).withOpacity(0.12),
                  name: 'search',
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Партнер нэрээр хайх',
                ),
              )
            : SizedBox(),
        actions: [
          selectedIndex == 0
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                  decoration: BoxDecoration(
                    color: Color(0xff767680).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset(
                    'images/grid.svg',
                    color: selectedIndex != 3 ? orderColor : white,
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: white,
                      addColor: orderColor,
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: buttonColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: orderColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? orderColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/home.svg',
                    color: selectedIndex == 0 ? white : buttonColor,
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: buttonColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? orderColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/dashboard.svg',
                    color: selectedIndex == 1 ? white : buttonColor,
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: buttonColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? orderColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/inbox.svg',
                    color: selectedIndex == 2 ? white : buttonColor,
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: buttonColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? orderColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/sent.svg',
                    color: selectedIndex == 3 ? white : buttonColor,
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: buttonColor, fontSize: 12),
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
