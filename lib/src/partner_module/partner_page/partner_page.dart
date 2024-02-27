import 'package:after_layout/after_layout.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/branches/branches_tab.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/businesses/businesses.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/warehouses/warehouses_tab.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/partner_profile.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatefulWidget {
  static const routeName = '/PartnerPage';
  const PartnerPage({super.key});

  @override
  PartnerPageState createState() => PartnerPageState();
}

class PartnerPageState extends State<PartnerPage> with AfterLayoutMixin {
  int selectedIndex = 0;
  bool isLoading = true;
  static const List<Widget> currentPages = [
    PartnerProfile(),
    Businesses(),
    BranchesTab(),
    WarehousesTab(),
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false)
        .partnerInit(true);
    await Provider.of<UserProvider>(context, listen: false).partnerMe(true);
    setState(() {
      isLoading = false;
    });
  }

  void ontappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: selectedIndex != 2 && selectedIndex != 3
              ? AppBar(
                  elevation: 0,
                  backgroundColor:
                      selectedIndex != 3 ? backgroundColor : partnerColor,
                  surfaceTintColor:
                      selectedIndex != 3 ? backgroundColor : partnerColor,
                  iconTheme: IconThemeData(
                      color: selectedIndex != 3 ? partnerColor : white),
                  title: Text(
                    selectedIndex == 0
                        ? 'Партнер профайл'
                        : selectedIndex == 1
                            ? "Бизнесүүд"
                            : selectedIndex == 2
                                ? "Салбарууд"
                                : 'Агуулахууд',
                    style: TextStyle(
                      color: selectedIndex != 3 ? partnerColor : white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : null,
          body: isLoading == true
              ? const SizedBox()
              : currentPages.elementAt(selectedIndex),
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
                icon: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedIndex == 0 ? partnerColor : white,
                      ),
                      padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                      child: SvgPicture.asset(
                        'assets/svg/profile.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            selectedIndex == 0 ? white : partnerColor,
                            BlendMode.srcIn),
                      ),
                    ),
                    if (selectedIndex != 0)
                      const Text(
                        'Профайл',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
                        color: selectedIndex == 1 ? partnerColor : white,
                      ),
                      padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                      child: SvgPicture.asset(
                        'assets/svg/business.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            selectedIndex == 1 ? white : partnerColor,
                            BlendMode.srcIn),
                      ),
                    ),
                    if (selectedIndex != 1)
                      const Text(
                        'Бизнесүүд',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
                        color: selectedIndex == 2 ? partnerColor : white,
                      ),
                      padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                      child: SvgPicture.asset(
                        'assets/svg/branch.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          selectedIndex == 2 ? white : partnerColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    if (selectedIndex != 2)
                      const Text(
                        'Салбарууд',
                        style: TextStyle(color: partnerColor, fontSize: 12),
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
                        color: selectedIndex == 3 ? partnerColor : white,
                      ),
                      padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                      child: SvgPicture.asset(
                        'assets/svg/warehouse.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            selectedIndex == 3 ? white : partnerColor,
                            BlendMode.srcIn),
                      ),
                    ),
                    if (selectedIndex != 3)
                      const Text(
                        'Агуулахууд',
                        style: TextStyle(color: partnerColor, fontSize: 12),
                      ),
                  ],
                ),
                label: '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
