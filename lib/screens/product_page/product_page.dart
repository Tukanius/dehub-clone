import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/product_page/tabs/home_page_tab/home_page_tab.dart';

class ProductPage extends StatefulWidget {
  static const routeName = 'productpage';
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

int selectedIndex = 0;

class _ProductPageState extends State<ProductPage> {
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
        backgroundColor: selectedIndex != 3 ? backgroundColor : productColor,
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
                  color: selectedIndex != 3 ? productColor : white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                      color: selectedIndex != 3 ? productColor : white,
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
                    color: selectedIndex != 3 ? productColor : white,
                  ),
                )
              : selectedIndex == 3
                  ? AddButton(
                      color: white,
                      addColor: productColor,
                    )
                  : SizedBox(),
        ],
      ),
      body: Container(
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
            icon: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 0 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/home.svg',
                    color: selectedIndex == 0 ? white : productColor,
                  ),
                ),
                selectedIndex != 0
                    ? Text(
                        'Нүүр',
                        style: TextStyle(color: productColor, fontSize: 12),
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
                    color: selectedIndex == 1 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/dashboard.svg',
                    color: selectedIndex == 1 ? white : productColor,
                  ),
                ),
                selectedIndex != 1
                    ? Text(
                        'Дашбоард',
                        style: TextStyle(color: productColor, fontSize: 12),
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
                    color: selectedIndex == 2 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/inbox.svg',
                    color: selectedIndex == 2 ? white : productColor,
                  ),
                ),
                selectedIndex != 2
                    ? Text(
                        'Ирсэн',
                        style: TextStyle(color: productColor, fontSize: 12),
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
                    color: selectedIndex == 3 ? productColor : white,
                  ),
                  padding: EdgeInsets.all(selectedIndex == 3 ? 7 : 0),
                  child: SvgPicture.asset(
                    'images/sent.svg',
                    color: selectedIndex == 3 ? white : productColor,
                  ),
                ),
                selectedIndex != 3
                    ? Text(
                        'Илгээсэн',
                        style: TextStyle(color: productColor, fontSize: 12),
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
