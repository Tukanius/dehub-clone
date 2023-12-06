import 'package:dehub/src/finance_module/screens/avaible_funding_page/request_approval_page.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/invoice.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/limit_tab.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/request_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AvaibleFundingDetailPage extends StatefulWidget {
  static const routeName = '/avaiblefundingdetailpage';
  const AvaibleFundingDetailPage({super.key});

  @override
  State<AvaibleFundingDetailPage> createState() =>
      _AvaibleFundingDetailPageState();
}

class _AvaibleFundingDetailPageState extends State<AvaibleFundingDetailPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  changePage(index) {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 205,
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
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
                  color: financingColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Санхүүжилт хүсэх',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade200,
            ),
            width: 35,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Material(
                  color: white,
                  elevation: 4,
                  child: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade100),
                    controller: tabController,
                    indicatorColor: financingColor,
                    labelColor: financingColor,
                    unselectedLabelColor: grey2,
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          'Нэхэмжлэх',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('Хүсэлт'),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('Лимит'),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              Stack(
                children: [
                  InvoiceTab(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      shape: CircleBorder(),
                      hoverColor: financingColor,
                      onPressed: () {
                        tabController.animateTo(tabController.index + 1);
                      },
                      child: Icon(
                        Icons.fast_forward_outlined,
                        color: white,
                      ),
                      backgroundColor: financingColor,
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  RequestTab(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      shape: CircleBorder(),
                      hoverColor: financingColor,
                      onPressed: () {
                        tabController.animateTo(tabController.index + 1);
                      },
                      child: Icon(
                        Icons.fast_forward_outlined,
                        color: white,
                      ),
                      backgroundColor: financingColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 20),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      hoverColor: financingColor,
                      shape: CircleBorder(),
                      onPressed: () {
                        tabController.animateTo(tabController.index - 1);
                      },
                      child: Icon(
                        Icons.fast_rewind_outlined,
                        color: white,
                      ),
                      backgroundColor: financingColor,
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  LimitTab(),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RequestApprovalPage.routeName);
                        // Navigator.of(context).pushNamed(
                        //   PinCheckScreen.routeName,
                        //   arguments: PinCheckScreenArguments(
                        //       onSubmit: () {},
                        //       color: financingColor,
                        //       labelText: "SCF Хүсэлт батлах",
                        //       description:
                        //           'Та SCF хүсэлт батлах гэж байна. Та мэдээллээ сайтар шалгана уу.'),
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: financingColor),
                        ),
                        child: Text(
                          'Санхүүжилт хүсэх',
                          style: TextStyle(
                            color: financingColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton.small(
                      hoverColor: financingColor,
                      shape: CircleBorder(),
                      onPressed: () {
                        tabController.animateTo(tabController.index - 1);
                      },
                      child: Icon(
                        Icons.fast_rewind_outlined,
                        color: white,
                      ),
                      backgroundColor: financingColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
