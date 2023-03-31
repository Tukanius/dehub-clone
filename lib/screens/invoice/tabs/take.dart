import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/screens/invoice/product_return/product_return.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class TakePage extends StatefulWidget {
  const TakePage({
    Key? key,
  }) : super(key: key);

  @override
  State<TakePage> createState() => _TakePageState();
}

class _TakePageState extends State<TakePage>
    with SingleTickerProviderStateMixin {
  int? selectedIndex;
  late TabController tabController = TabController(length: 5, vsync: this);
  int currentIndex = 0;

  void onItemTapped() {
    setState(() {
      tabController.index == currentIndex;
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
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == 0
                          ? brownButtonColor
                          : Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Бүгд',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentIndex == 0 ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == 1
                          ? brownButtonColor
                          : Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Төлбөр хүлээгдэж буй',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentIndex == 1 ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == 2
                          ? brownButtonColor
                          : Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Хаагдсан',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentIndex == 2 ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == 3
                          ? brownButtonColor
                          : Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Драфт',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentIndex == 3 ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == 4
                          ? brownButtonColor
                          : Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 4;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Батлуулах',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentIndex == 4 ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SearchButton(
              color: brownButtonColor,
            ),
          )
        ];
      },
      body: InvoiceCard(
        onClick: () {
          Navigator.of(context).pushNamed(ProductReturnPage.routeName);
        },
      ),
    );
  }
}
