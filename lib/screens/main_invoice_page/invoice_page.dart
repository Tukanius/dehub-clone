import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/main_invoice_page/tabs/home_page_tab.dart';

class MainInvoicePage extends StatefulWidget {
  static const routeName = 'MainInvoicePage';
  const MainInvoicePage({super.key});

  @override
  State<MainInvoicePage> createState() => _MainInvoicePageState();
}

int selectedIndex = 0;

class _MainInvoicePageState extends State<MainInvoicePage> {
  static const List<Widget> currentPages = [
    HomePageTab(),
    Text('1'),
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
        fixedColor: invoiceColor,
        onTap: ontappedItem,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: invoiceColor,
            ),
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/dashboard.svg',
              color: invoiceColor,
            ),
            label: 'Дашбоард',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/inbox.svg',
              color: invoiceColor,
            ),
            label: 'Зарлага',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/sent.svg',
              color: invoiceColor,
            ),
            label: 'Орлого',
          ),
        ],
      ),
    );
  }
}
