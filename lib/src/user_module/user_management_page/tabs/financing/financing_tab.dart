import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/financing/tabs/banks.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/financing/tabs/finance_role.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancingTab extends StatefulWidget {
  const FinancingTab({super.key});

  @override
  State<FinancingTab> createState() => _FinancingTabState();
}

class _FinancingTabState extends State<FinancingTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  User user = User();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).userModule;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: TabBar(
              controller: tabController,
              labelColor: userColor,
              unselectedLabelColor: grey2,
              indicatorColor: userColor,
              overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
              tabs: const [
                Tab(
                  text: 'SCF/DCF банк',
                ),
                Tab(
                  text: 'Эрхийн түүх',
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          Permission().check(user, "USR_FR")
              ? const BanksTab()
              : const NotFound(module: "Хандах эрх хүрэлцэхгүй байна"),
          Permission().check(user, "USR_FR")
              ? const FinanceRole()
              : const NotFound(module: "Хандах эрх хүрэлцэхгүй байна"),
        ],
      ),
    );
  }
}
