import 'package:dehub/screens/account_info_page/tabs/index0.dart';
import 'package:dehub/screens/account_info_page/tabs/index1.dart';

import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountInfoPage extends StatefulWidget {
  static const routeName = 'accountinfopage';
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
        ),
        title: tabController.index == 1
            ? Text(
                'Дансны түүх',
                style: TextStyle(color: black, fontSize: 18),
              )
            : Text(
                'Дансны мэдээлэл',
                style: TextStyle(color: black, fontSize: 18),
              ),
        centerTitle: true,
        actions: [
          tabController.index == 1
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 20),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: neonGreen,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SvgPicture.asset(
                      'images/yuluur1.svg',
                    ),
                  ),
                )
              : SizedBox(),
        ],
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: neonGreen,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        '521****513',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: neonGreen),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Голомт банк, Дэлгэрэх хүнс',
                      style: TextStyle(fontSize: 15, color: grey2),
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              changePage(0);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: tabController.index == 0
                                      ? transparent
                                      : grey2,
                                  width: 0.5,
                                ),
                                color: tabController.index == 0
                                    ? neonGreen
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/setting_eye.svg',
                                color: tabController.index != 0 ? grey2 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(1);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: tabController.index == 1
                                        ? transparent
                                        : grey2,
                                    width: 0.5,
                                  ),
                                  color: tabController.index == 1
                                      ? neonGreen
                                      : white,
                                ),
                                child: Icon(
                                  Icons.history,
                                  color:
                                      tabController.index != 1 ? grey2 : white,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(2);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: tabController.index == 2
                                      ? transparent
                                      : grey2,
                                  width: 0.5,
                                ),
                                color: tabController.index == 2
                                    ? neonGreen
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/grey_income.svg',
                                color: tabController.index != 2 ? grey2 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(3);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: tabController.index == 3
                                      ? transparent
                                      : grey2,
                                  width: 0.5,
                                ),
                                color: tabController.index == 3
                                    ? neonGreen
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/grey_outgoing.svg',
                                color: tabController.index != 3 ? grey2 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(4);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: tabController.index == 4
                                      ? transparent
                                      : grey2,
                                  width: 0.5,
                                ),
                                color: tabController.index == 4
                                    ? neonGreen
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/paper.svg',
                                color: tabController.index != 4 ? grey2 : white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Index0(),
              Index1(),
              Text('3'),
              Text('4'),
              Text('5'),
            ],
          ),
        ),
      ),
    );
  }
}
