import 'package:after_layout/after_layout.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/address_information.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/main_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BranchCreateArguments {
  Partner? data;
  ListenController listenController;
  BranchCreateArguments({
    this.data,
    required this.listenController,
  });
}

class BranchCreate extends StatefulWidget {
  static const routeName = '/BranchCreate';
  final Partner? data;
  final ListenController listenController;
  const BranchCreate({
    super.key,
    this.data,
    required this.listenController,
  });

  @override
  State<BranchCreate> createState() => _BranchCreateState();
}

class _BranchCreateState extends State<BranchCreate>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late TabController tabController;
  bool isLoading = true;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<PartnerProvider>(context, listen: false).clearData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: partnerColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Салбар нэмэх',
          style: TextStyle(
            color: partnerColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          labelColor: partnerColor,
          indicatorColor: partnerColor,
          unselectedLabelColor: grey2,
          overlayColor: const MaterialStatePropertyAll(transparent),
          onTap: (value) {
            if (tabController.indexIsChanging) {
              tabController.index = tabController.previousIndex;
            } else {
              return;
            }
          },
          tabs: const [
            Tab(
              text: "Үндсэн мэдээлэл",
            ),
            Tab(
              text: "Хаягийн мэдээлэл",
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? const SizedBox()
          : TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                MainInformation(
                  listenController: widget.listenController,
                  tabController: tabController,
                  data: widget.data,
                ),
                AddressInformation(
                  listenController: widget.listenController,
                  data: widget.data,
                ),
              ],
            ),
    );
  }
}
