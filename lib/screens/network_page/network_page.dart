import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/inbox_tab.dart';
import 'package:dehub/screens/network_page/tabs/partner_tab/partner_tab.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/sent_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab.dart';

class NetworkPage extends StatefulWidget {
  static const routeName = 'networkpage';
  const NetworkPage({Key? key}) : super(key: key);

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  int selectedIndex = 0;
  static const List<Widget> currentPages = [
    DashboardTab(),
    PartnerTab(),
    InboxTab(),
    SentTab(),
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
        backgroundColor: selectedIndex != 3 ? backgroundColor : networkColor,
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
                  color: selectedIndex != 3 ? networkColor : white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                      color: selectedIndex != 3 ? networkColor : white,
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
                    color: selectedIndex != 3 ? networkColor : white,
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: white,
                      addColor: networkColor,
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedIconTheme: IconThemeData(color: networkColor),
        fixedColor: networkColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/dashboard.svg',
              color: networkColor,
            ),
            label: 'Дашбоард',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/partners.svg',
              color: networkColor,
            ),
            label: 'Харилцагч',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/inbox.svg',
              color: networkColor,
            ),
            label: 'Ирсэн',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/sent.svg',
              color: networkColor,
            ),
            label: 'Илгээсэн',
          ),
        ],
      ),
    );
  }
}
