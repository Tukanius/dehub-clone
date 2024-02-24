import 'package:dehub/src/user_module/user_management_page/tabs/financing/tabs/banks.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class FinancingTab extends StatefulWidget {
  const FinancingTab({super.key});

  @override
  State<FinancingTab> createState() => _FinancingTabState();
}

class _FinancingTabState extends State<FinancingTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: TabBar(
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
        body: const TabBarView(
          children: [
            BanksTab(),
            Text('1'),
            Text('1'),
          ],
        ),
      ),
    );
  }
}
