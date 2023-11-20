// import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
// import 'package:dehub/src/new_order/new_order.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/order_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/order_module/order_page/tabs/dashboard_tab.dart';
import 'package:dehub/src/order_module/order_page/tabs/customer_tab/customer_tab.dart';
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
    await Provider.of<GeneralProvider>(context, listen: false).orderInit(true);
    await Provider.of<UserProvider>(context, listen: false).order(true);
    setState(() {
      isLoading = false;
    });
  }

  int selectedIndex = 1;

  static const List<Widget> currentPages = [
    NotFound(
      module: "ORDER",
      labelText: "Хоосон байна",
    ),
    DashboardTab(),
    OrderTab(),
    CustomerTab(),
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
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: orderColor,
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
            : selectedIndex == 2
                ? Text(
                    'Захиалгын жагсаалт',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : selectedIndex == 3
                    ? Text(
                        'Харилцагчийн жагсаалт',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : SizedBox(),
        centerTitle: true,
        actions: [
          isLoading == true
              ? SizedBox()
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15, top: 9, bottom: 9),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey,
                  ),
                  child: Center(
                    child: Text(
                      '${user.currentBusiness?.profileName?[0].toUpperCase()}${user.currentBusiness?.profileName?[1].toUpperCase()}',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ],
        bottom: PreferredSize(
          child: Container(
            color: orderColor,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
      ),
      body: isLoading == true
          ? SizedBox()
          : Container(
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
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedIndex == 0 ? orderColor : white,
                    ),
                    padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? white : orderColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  selectedIndex != 0
                      ? Text(
                          'Нүүр',
                          style: TextStyle(color: orderColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? orderColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'assets/svg/dashboard.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? white : orderColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: orderColor, fontSize: 12),
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
                    'assets/svg/order.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? white : orderColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Захиалга',
                        style: TextStyle(color: orderColor, fontSize: 12),
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
                    'assets/svg/order_customer.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 3 ? white : orderColor,
                        BlendMode.srcIn),
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Харилцагч',
                        style: TextStyle(color: orderColor, fontSize: 12),
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
