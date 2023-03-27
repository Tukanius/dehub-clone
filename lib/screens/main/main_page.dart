import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/home/home_page.dart';
import 'package:dehub/screens/invoice/invoice.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/MainPage';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    color: black,
    fontSize: 10,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    InvoicePage(),
    Text(
      'Index 2: Төлбөр',
      style: optionStyle,
    ),
    Text(
      'Index 3: Захиалга',
      style: optionStyle,
    ),
  ];

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: _selectedIndex == 1 ? buttonColor2 : buttonColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Icon(Icons.menu_outlined),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notification_add_outlined,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          _selectedIndex == 1
              ? AddButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(NewInvoice.routeName);
                  },
                )
              : Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfilePage.routeName);
                    },
                    child: Ink(
                      height: 30,
                      width: 30,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                      ),
                      child: Image(
                        image: AssetImage(
                          'images/icon.png',
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            backgroundColor: buttonColor,
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_rounded),
            backgroundColor: buttonColor2,
            label: 'Нэхэмжлэх',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/tolbor.svg'),
            backgroundColor: black,
            label: 'Төлбөр',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            backgroundColor: black,
            label: 'Захиалга',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTappedItem,
      ),
    );
  }
}
