import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/home_page/home_page.dart';
import 'package:dehub/screens/invoice/invoice_page.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  int? selectedIndex;
  static const routeName = '/MainPage';
  MainPage({
    Key? key,
    this.selectedIndex,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> currentPages = <Widget>[
    HomePage(),
    InvoicePage(),
    VerticalDivider(),
    Text(
      'Index 3: Захиалга',
    ),
  ];

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: _selectedIndex == 1
            ? brownButtonColor
            : _selectedIndex == 2
                ? purpleButtonColor
                : buttonColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(MenuPage.routeName);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              'images/menu.svg',
            ),
          ),
        ),
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
                  color: Colors.orange,
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
                    child: Container(
                      decoration: BoxDecoration(),
                      child: user.avatar == null
                          ? CircleAvatar(
                              radius: 15,
                              child: ClipOval(
                                child: Image(
                                    image: NetworkImage(
                                  'https://i0.wp.com/a.slack-edge.com/df10d/img/avatars/ava_0024-192.png?ssl=1',
                                )),
                              ),
                            )
                          : CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage('${user.avatar}'),
                            ),
                    ),
                  ),
                ),
        ],
      ),
      body: Center(
        child: currentPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            backgroundColor: buttonColor,
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/binvoice.svg'),
            backgroundColor: brownButtonColor,
            label: 'Нэхэмжлэх',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/tolbor.svg'),
            backgroundColor: purpleButtonColor,
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
