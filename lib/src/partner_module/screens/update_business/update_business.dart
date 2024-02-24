import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import './tabs/main_information.dart';
import './tabs/marketing_information.dart';

class UpdateBusinessArguments {
  Partner? data;
  ListenController listenController;
  UpdateBusinessArguments({
    this.data,
    required this.listenController,
  });
}

class UpdateBusiness extends StatefulWidget {
  static const routeName = '/UpdateBusiness';
  final Partner? data;
  final ListenController listenController;
  const UpdateBusiness({
    super.key,
    this.data,
    required this.listenController,
  });

  @override
  State<UpdateBusiness> createState() => _UpdateBusinessState();
}

class _UpdateBusinessState extends State<UpdateBusiness>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: partnerColor),
        title: const Text(
          'Бизнесийн мэдээлэл',
          style: TextStyle(
            color: partnerColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          indicatorColor: partnerColor,
          labelColor: partnerColor,
          unselectedLabelColor: grey2,
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
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
              text: 'Үндсэн мэдээлэл',
            ),
            Tab(
              text: 'Маркетингийн мэдээлэл',
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          MainInformation(
            tabController: tabController,
            listenController: widget.listenController,
            data: widget.data,
          ),
          MarketingInformation(
            data: widget.data,
            listenController: widget.listenController,
          ),
        ],
      ),
    );
  }
}
