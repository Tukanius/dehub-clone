import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/payment_page/tabs/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/screens/link_account_page/link_account_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/payment_page/tabs/home_page_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/PaymentPage';
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

int selectedIndex = 0;

class _PaymentPageState extends State<PaymentPage> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).payment(true);
    await Provider.of<GeneralProvider>(context, listen: false)
        .paymentInit(true);
  }

  static const List<Widget> currentPages = [
    HomePageTab(),
    AddBankAccountPage(),
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
        backgroundColor: selectedIndex != 3 ? white : paymentColor,
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
                  color: selectedIndex != 3 ? paymentColor : white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                      color: selectedIndex != 3 ? paymentColor : white,
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
                    color: selectedIndex != 3 ? paymentColor : white,
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: paymentColor,
                      addColor: white,
                      onClick: () {
                        Navigator.of(context)
                            .pushNamed(LinkAccountPage.routeName);
                      },
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: paymentColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: paymentColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/home.svg',
                    color: selectedIndex == 0 ? white : paymentColor,
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: paymentColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/dashboard.svg',
                    color: selectedIndex == 1 ? white : paymentColor,
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: paymentColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/inbox.svg',
                    color: selectedIndex == 2 ? white : paymentColor,
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: paymentColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? paymentColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/sent.svg',
                    color: selectedIndex == 3 ? white : paymentColor,
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: paymentColor, fontSize: 12),
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
