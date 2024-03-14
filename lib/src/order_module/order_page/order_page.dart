import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/order_page/tabs/customer_order/customer_order.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/order_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/order_module/order_page/tabs/dashboard_tab/dashboard_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  static const routeName = '/OrderPage';
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AfterLayoutMixin {
  User user = User();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<IndexProvider>(context, listen: false).indexChange(1);
    await Provider.of<GeneralProvider>(context, listen: false).orderInit(true);
    await Provider.of<UserProvider>(context, listen: false).order(true);
    setState(() {
      isLoading = false;
    });
  }

  static const List<Widget> currentPages = [
    NotFound(
      module: "ORDER",
      labelText: "Хоосон байна",
    ),
    DashboardTab(),
    CustomerOrder(),
    OrderTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<IndexProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: orderColor),
        title: index.selectedIndex == 0
            ? FormTextField(
                inputType: TextInputType.text,
                color: const Color(0xff767680).withOpacity(0.12),
                name: 'search',
                prefixIcon: const Icon(Icons.search),
                hintText: 'Партнер нэрээр хайх',
              )
            : index.selectedIndex == 3
                ? const Text(
                    'Борлуулалтын захиалга',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : index.selectedIndex == 2
                    ? const Text(
                        'Харилцагчийн захиалга',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
        centerTitle: true,
        actions: [
          isLoading == true
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey,
                  ),
                  child: Center(
                    child: Text(
                      '${user.currentBusiness?.profileName?[0].toUpperCase()}${user.currentBusiness?.profileName?[1].toUpperCase()}',
                      style: const TextStyle(
                          color: black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: orderColor,
            height: 1.0,
          ),
        ),
      ),
      body: isLoading == true
          ? const SizedBox()
          : Container(
              child: currentPages.elementAt(index.selectedIndex),
            ),
      bottomNavigationBar: isLoading == false
          ? BottomNavigationBar(
              unselectedItemColor: buttonColor,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: white,
              type: BottomNavigationBarType.fixed,
              fixedColor: orderColor,
              onTap: (value) {
                if (value != 0) {
                  index.indexChange(value);
                } else {
                  Navigator.of(context).pop();
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
                            color:
                                index.selectedIndex == 0 ? orderColor : white,
                          ),
                          padding:
                              EdgeInsets.all(index.selectedIndex == 0 ? 7 : 0),
                          child: SvgPicture.asset(
                            'assets/svg/home.svg',
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                                index.selectedIndex == 0 ? white : orderColor,
                                BlendMode.srcIn),
                          ),
                        ),
                        if (index.selectedIndex != 0)
                          const Text(
                            'Нүүр',
                            style: TextStyle(color: orderColor, fontSize: 12),
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
                          color: index.selectedIndex == 1 ? orderColor : white,
                        ),
                        padding:
                            EdgeInsets.all(index.selectedIndex == 1 ? 7 : 0),
                        child: SvgPicture.asset(
                          'assets/svg/dashboard.svg',
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                              index.selectedIndex == 1 ? white : orderColor,
                              BlendMode.srcIn),
                        ),
                      ),
                      if (index.selectedIndex != 1)
                        const Text(
                          'Дашбоард',
                          style: TextStyle(color: orderColor, fontSize: 12),
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
                          color: index.selectedIndex == 2 ? orderColor : white,
                        ),
                        padding:
                            EdgeInsets.all(index.selectedIndex == 2 ? 7 : 0),
                        child: SvgPicture.asset(
                          'assets/svg/box.svg',
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                              index.selectedIndex == 2 ? white : orderColor,
                              BlendMode.srcIn),
                        ),
                      ),
                      if (index.selectedIndex != 2)
                        const Text(
                          'Харилцагч',
                          style: TextStyle(color: orderColor, fontSize: 12),
                        ),
                    ],
                  ),
                  label: '',
                ),
                if (user.currentBusiness?.type == "SUPPLIER")
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                index.selectedIndex == 3 ? orderColor : white,
                          ),
                          padding:
                              EdgeInsets.all(index.selectedIndex == 3 ? 7 : 0),
                          child: SvgPicture.asset(
                            'assets/svg/order.svg',
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                                index.selectedIndex == 3 ? white : orderColor,
                                BlendMode.srcIn),
                          ),
                        ),
                        if (index.selectedIndex != 3)
                          const Text(
                            'Захиалга',
                            style: TextStyle(color: orderColor, fontSize: 12),
                          ),
                      ],
                    ),
                    label: '',
                  ),
              ],
            )
          : null,
    );
  }
}
