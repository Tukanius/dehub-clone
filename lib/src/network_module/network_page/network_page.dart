import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/inbox_tab.dart';
import 'package:dehub/src/network_module/network_page/tabs/sent_tab/sent_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/network_module/network_page/tabs/dashboard_tab/dashboard_tab.dart';
import 'package:dehub/src/network_module/network_page/tabs/home_tab/home_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class NetworkPage extends StatefulWidget {
  static const routeName = '/NetworkPage';
  const NetworkPage({super.key});

  @override
  NetworkPageState createState() => NetworkPageState();
}

class NetworkPageState extends State<NetworkPage> with AfterLayoutMixin {
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<IndexProvider>(context, listen: false).indexChange(1);
    await Provider.of<UserProvider>(context, listen: false).businessMe(true);
    await Provider.of<GeneralProvider>(context, listen: false)
        .businessInit(true);
    setState(() {
      isLoading = false;
    });
  }

  static List<dynamic> currentPages = [
    const HomeTab(),
    const DashboardTab(),
    const InboxTab(),
    const SentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<IndexProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: index.selectedIndex != 3
          ? AppBar(
              leadingWidth: 100,
              elevation: 0,
              backgroundColor:
                  index.selectedIndex != 3 ? backgroundColor : networkColor,
              surfaceTintColor:
                  index.selectedIndex != 3 ? backgroundColor : networkColor,
              leading: CustomBackButton(
                color: index.selectedIndex != 3 ? networkColor : white,
              ),
              title: index.selectedIndex == 0
                  ? FormTextField(
                      inputType: TextInputType.text,
                      color: const Color(0xff767680).withOpacity(0.12),
                      name: 'search',
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Партнер нэрээр хайх',
                    )
                  : const SizedBox(),
              actions: [
                index.selectedIndex == 0
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        margin:
                            const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                        decoration: BoxDecoration(
                          color: const Color(0xff767680).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/grid.svg',
                          colorFilter: ColorFilter.mode(
                              index.selectedIndex != 3 ? networkColor : white,
                              BlendMode.srcIn),
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          : null,
      body: isLoading == true
          ? const SizedBox()
          : Container(
              child: currentPages.elementAt(index.selectedIndex),
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: networkColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: networkColor,
        onTap: (value) {
          if (value == 0) {
            Navigator.of(context).pop();
          } else {
            index.indexChange(value);
          }
        },
        currentIndex: index.selectedIndex,
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
                      color: index.selectedIndex == 0 ? networkColor : white,
                    ),
                    padding: EdgeInsets.all(index.selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          index.selectedIndex == 0 ? white : networkColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  if (index.selectedIndex != 0)
                    const Text(
                      'Нүүр',
                      style: TextStyle(color: networkColor, fontSize: 12),
                    ),
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
                    color: index.selectedIndex == 1 ? networkColor : white,
                  ),
                  padding: EdgeInsets.all(index.selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        index.selectedIndex == 1 ? white : networkColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (index.selectedIndex != 1)
                  const Text(
                    'Дашбоард',
                    style: TextStyle(color: networkColor, fontSize: 12),
                  ),
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
                    color: index.selectedIndex == 2 ? networkColor : white,
                  ),
                  padding: EdgeInsets.all(index.selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/inbox.svg',
                    colorFilter: ColorFilter.mode(
                        index.selectedIndex == 2 ? white : networkColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (index.selectedIndex != 2)
                  const Text(
                    'Ирсэн',
                    style: TextStyle(color: networkColor, fontSize: 12),
                  ),
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
                    color: index.selectedIndex == 3 ? networkColor : white,
                  ),
                  padding: EdgeInsets.all(index.selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/sent.svg',
                    colorFilter: ColorFilter.mode(
                        index.selectedIndex == 3 ? white : networkColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (index.selectedIndex != 3)
                  const Text(
                    'Илгээсэн',
                    style: TextStyle(color: networkColor, fontSize: 12),
                  ),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
