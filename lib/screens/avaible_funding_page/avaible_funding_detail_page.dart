import 'package:dehub/screens/avaible_funding_page/request_approval_page.dart';
import 'package:dehub/screens/avaible_funding_page/tabs/invoice.dart';
import 'package:dehub/screens/avaible_funding_page/tabs/limit_tab.dart';
import 'package:dehub/screens/avaible_funding_page/tabs/request_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AvaibleFundingDetailPage extends StatefulWidget {
  static const routeName = '/avaiblefundingdetailpage';
  const AvaibleFundingDetailPage({super.key});

  @override
  State<AvaibleFundingDetailPage> createState() =>
      _AvaibleFundingDetailPageState();
}

class _AvaibleFundingDetailPageState extends State<AvaibleFundingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 200,
        elevation: 0,
        backgroundColor: backgroundColor,
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
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: TabBar(
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
            children: [
              Stack(
                children: [
                  InvoiceTab(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      hoverColor: financingColor,
                      onPressed: () {},
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
                      hoverColor: financingColor,
                      onPressed: () {},
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
                      onPressed: () {},
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
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RequestApprovalPage.routeName);
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
                      onPressed: () {},
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
