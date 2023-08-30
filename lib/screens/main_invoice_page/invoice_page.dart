import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/main_invoice_page/tabs/dashboard_tab/dashboard_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class MainInvoicePage extends StatefulWidget {
  static const routeName = '/MainInvoicePage';
  const MainInvoicePage({super.key});

  @override
  State<MainInvoicePage> createState() => _MainInvoicePageState();
}

int selectedIndex = 0;

class _MainInvoicePageState extends State<MainInvoicePage>
    with AfterLayoutMixin {
  General general = General();

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false).init(true);
    await Provider.of<UserProvider>(context, listen: false).invoice(true);
  }

  static const List<Widget> currentPages = [
    Text('1'),
    DashBoardTab(),
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
        backgroundColor: selectedIndex != 3 ? backgroundColor : invoiceColor,
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
                  color: selectedIndex != 3 ? invoiceColor : white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                      color: selectedIndex != 3 ? invoiceColor : white,
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
                    color: selectedIndex != 3 ? invoiceColor : white,
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: white,
                      addColor: invoiceColor,
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
        child: currentPages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: invoiceColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        fixedColor: invoiceColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/home.svg',
                    color: selectedIndex == 0 ? white : invoiceColor,
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: invoiceColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/dashboard.svg',
                    color: selectedIndex == 1 ? white : invoiceColor,
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: invoiceColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/bill.svg',
                    color: selectedIndex == 2 ? white : invoiceColor,
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Тооцоо',
                        style: TextStyle(color: invoiceColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? invoiceColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/document.svg',
                    color: selectedIndex == 3 ? white : invoiceColor,
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Баримт',
                        style: TextStyle(color: invoiceColor, fontSize: 12),
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
