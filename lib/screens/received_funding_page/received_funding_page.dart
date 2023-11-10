import 'package:dehub/components/avaible_funding_card/give_funding_card.dart';
import 'package:dehub/components/avaible_funding_card/received_funding_card.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceivedFundingPage extends StatefulWidget {
  static const routeName = '/ReceivedFundingPage';
  const ReceivedFundingPage({super.key});

  @override
  State<ReceivedFundingPage> createState() => _ReceivedFundingPageState();
}

class _ReceivedFundingPageState extends State<ReceivedFundingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: CustomBackButton(color: financingColor),
      ),
      body: DefaultTabController(
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
                      margin: const EdgeInsets.only(left: 15, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: financingColor.withOpacity(0.1),
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/camera.svg',
                              color: financingColor,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Авсан санхүүжилт',
                            style: TextStyle(
                                fontSize: 11.5, fontWeight: FontWeight.w500),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Text(
                        'Авсан санхүүжилт',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(0);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: tabController.index == 0
                                  ? financingColor
                                  : backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Buyer-Led',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: tabController.index == 0 ? white : black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: tabController.index == 1
                                  ? financingColor
                                  : backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Supplier-Led',
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
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              ReceivedFundingCard(),
              GiveFundingCard(),
            ],
          ),
        ),
      ),
    );
  }
}
