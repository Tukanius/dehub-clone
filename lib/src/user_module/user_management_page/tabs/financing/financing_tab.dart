import 'package:dehub/src/user_module/user_management_page/tabs/financing/tabs/banks.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/financing/tabs/finance_role.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class FinancingTab extends StatefulWidget {
  const FinancingTab({super.key});

  @override
  State<FinancingTab> createState() => _FinancingTabState();
}

class _FinancingTabState extends State<FinancingTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: tabController.index == 1
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: userColor,
              onPressed: () {},
              child: const Icon(
                Icons.add,
                color: white,
              ),
            )
          : const SizedBox(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: TabBar(
                controller: tabController,
                labelColor: userColor,
                unselectedLabelColor: grey2,
                indicatorColor: userColor,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
                tabs: const [
                  Tab(
                    text: 'SCF/DCF банк',
                  ),
                  Tab(
                    text: 'Эрхийн түүх',
                  ),
                  Tab(
                    text: 'Системийн лог',
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const [
            BanksTab(),
            FinanceRole(),
            Text(''),
          ],
        ),
      ),
    );
  }
}
