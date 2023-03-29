import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/screens/invoice/tabs/gives_tabbars/all.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TakePage extends StatefulWidget {
  const TakePage({Key? key}) : super(key: key);

  @override
  State<TakePage> createState() => _TakePageState();
}

var menu = [
  'Бүгд',
  'Төлбөр хүлээж буй',
  'Хаагдсан',
  'Драфт',
  'Батлуулах',
];

class _TakePageState extends State<TakePage> {
  int? selectedIndex;

  int currentIndex = 0;

  click(item) {
    switch (item) {
      case 'Бүгд':
        return currentIndex = 0;
      case 'Төлбөр хүлээж буй':
        return currentIndex = 1;
      case 'Хаагдсан':
        return currentIndex = 2;
      case 'Драфт':
        return currentIndex = 3;

      case 'Батлуулах':
        return currentIndex = 4;

      default:
    }
  }

  void onItemTapped() {
    setState(() {
      selectedIndex == currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              color: white,
              height: 50,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: menu
                    .map(
                      (item) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, right: 5, left: 5),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: buttonColor2,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              click(item);
                            });
                          },
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: [
          // SearchButton(),
          currentIndex != 3 ? SearchButton() : SizedBox(),
          currentIndex == 1
              ? Container(
                  width: 100,
                  height: 100,
                  color: black,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
