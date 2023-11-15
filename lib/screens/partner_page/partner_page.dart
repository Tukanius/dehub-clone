import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/partner_page/tabs/home_page.dart';
import 'package:dehub/screens/partner_page/tabs/partner_tab/partner_tab.dart';
import 'package:dehub/screens/partner_page/tabs/inbox_tab/inbox_tab.dart';
import 'package:dehub/screens/partner_page/tabs/sent_tab/sent_tab.dart';

class PartnerPage extends StatefulWidget {
  static const routeName = '/PartnerPage';
  const PartnerPage({Key? key}) : super(key: key);

  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  int selectedIndex = 1;
  static const List<Widget> currentPages = [
    HomePage(),
    PartnerTab(),
    InboxTab(),
    SentTab(),
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
        backgroundColor: selectedIndex != 3 ? backgroundColor : partnerColor,
        leading: CustomBackButton(
          color: selectedIndex != 3 ? partnerColor : white,
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
                    'assets/svg/grid.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex != 3 ? partnerColor : white,
                        BlendMode.srcIn),
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: white,
                      addColor: partnerColor,
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: partnerColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: partnerColor,
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
                      color: selectedIndex == 0 ? partnerColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : partnerColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  selectedIndex != 0
                      ? Text(
                          'Нүүр',
                          style: TextStyle(color: partnerColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? partnerColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : partnerColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? partnerColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/inbox.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : partnerColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? partnerColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/sent.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : partnerColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
