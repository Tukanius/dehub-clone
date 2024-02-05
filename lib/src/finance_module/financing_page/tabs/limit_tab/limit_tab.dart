import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/financing_page/tabs/limit_tab/tabs/current_asset.dart';
import 'package:dehub/src/finance_module/financing_page/tabs/limit_tab/tabs/investment_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LimitTab extends StatefulWidget {
  const LimitTab({super.key});

  @override
  State<LimitTab> createState() => _LimitTabState();
}

class _LimitTabState extends State<LimitTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Column(
      children: [
        TabBar(
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicatorColor: source.currentColor,
          labelColor: source.currentColor,
          unselectedLabelColor: grey2,
          tabs: const [
            Tab(
              text: 'Зээл суурьтай',
            ),
            Tab(
              text: 'Нэхэмжлэх барьцаалсан',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              InvestmentTab(),
              CurrentAssetTab(),
            ],
          ),
        ),
      ],
    );
  }
}
