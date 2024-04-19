import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/product_page/tabs/dashboard_tab/dashboard_tab.dart';
import 'package:dehub/src/product_module/product_page/tabs/price_tab/price_tab.dart';
import 'package:dehub/src/product_module/product_page/tabs/resource_tab/resource_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/productpage';
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with AfterLayoutMixin {
  int selectedIndex = 1;
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false)
        .inventoryInit(true);
    await Provider.of<UserProvider>(context, listen: false).inventory(true);
    setState(() {
      isLoading = false;
    });
  }

  static const List<Widget> currentPages = [
    SizedBox(),
    DashboardTab(),
    PriceTab(),
    ResourceTab(),
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
        backgroundColor: selectedIndex != 3 ? backgroundColor : productColor,
        surfaceTintColor: selectedIndex != 3 ? backgroundColor : productColor,
        leading: CustomBackButton(
          color: selectedIndex != 3 ? productColor : white,
        ),
        title: selectedIndex == 1
            ? FormTextField(
                inputType: TextInputType.text,
                color: const Color(0xff767680).withOpacity(0.12),
                name: 'search',
                prefixIcon: const Icon(Icons.search),
                hintText: 'Партнер нэрээр хайх',
              )
            : const SizedBox(),
        actions: [
          selectedIndex == 1
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xff767680).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/grid.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex != 3 ? productColor : white,
                        BlendMode.srcIn),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: isLoading == true
          ? const SizedBox()
          : Container(
              child: currentPages.elementAt(selectedIndex),
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: productColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: productColor,
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
                      color: selectedIndex == 0 ? productColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : productColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  if (selectedIndex != 0)
                    const Text(
                      'Нүүр',
                      style: TextStyle(color: productColor, fontSize: 12),
                    )
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
                    color: selectedIndex == 1 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : productColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 1)
                  const Text(
                    'Дашбоард',
                    style: TextStyle(color: productColor, fontSize: 12),
                  )
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
                    color: selectedIndex == 2 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: Icon(
                    CupertinoIcons.person,
                    color: selectedIndex != 2 ? productColor : white,
                  ),
                ),
                if (selectedIndex != 2)
                  const Text(
                    'Үнэ',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  )
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
                    color: selectedIndex == 3 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 10 : 3),
                  child: SvgPicture.asset(
                    'assets/svg/zahialga.svg',
                    height: 17,
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : productColor,
                        BlendMode.srcIn),
                  ),
                ),
                if (selectedIndex != 3)
                  const Text(
                    'Нөөц',
                    style: TextStyle(color: productColor, fontSize: 12),
                  )
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
