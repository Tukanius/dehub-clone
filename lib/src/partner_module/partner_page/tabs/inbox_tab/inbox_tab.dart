import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/tabs/from_bank.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/tabs/from_buyer.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({Key? key}) : super(key: key);

  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

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
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'Ирсэн урилга',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changePage(0);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tabController.index == 0
                                ? partnerColor
                                : backgroundColor,
                          ),
                          child: Text(
                            'Худалдан авагчаас',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: tabController.index == 0 ? white : black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          changePage(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tabController.index == 1
                                ? partnerColor
                                : backgroundColor,
                          ),
                          child: Text(
                            'Банкнаас',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: tabController.index == 1 ? white : black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            FromBuyer(),
            FromBank(),
          ],
        ),
      ),
    );
  }
}
