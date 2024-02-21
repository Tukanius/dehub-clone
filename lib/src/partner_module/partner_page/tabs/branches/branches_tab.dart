import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/partner_module/screens/branch_create/branch_create.dart';
import './components/branch_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BranchesTab extends StatefulWidget {
  const BranchesTab({super.key});

  @override
  State<BranchesTab> createState() => _BranchesTabState();
}

class _BranchesTabState extends State<BranchesTab> with AfterLayoutMixin {
  Result branches = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  bool startAnimation = false;
  final RefreshController refreshController = RefreshController();
  ListenController listenController = ListenController();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    branches = await PartnerApi()
        .branchList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        title: const Text(
          "Салбарууд",
          style: TextStyle(
            color: partnerColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: partnerColor),
        actions: [
          AddButton(
            addColor: white,
            color: partnerColor,
            onClick: () {
              Navigator.of(context).pushNamed(
                BranchCreate.routeName,
                arguments: BranchCreateArguments(
                  data: null,
                  listenController: listenController,
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: partnerColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              color: partnerColor,
              child: SingleChildScrollView(
                child: branches.rows!.isNotEmpty
                    ? Column(
                        children: [
                          Column(
                            children: branches.rows!
                                .map(
                                  (e) => BranchCard(
                                    index: branches.rows!.indexOf(e),
                                    startAnimation: startAnimation,
                                    data: e,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        BranchCreate.routeName,
                                        arguments: BranchCreateArguments(
                                          listenController: listenController,
                                          data: e,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      )
                    : const NotFound(
                        module: "PARTNER",
                        labelText: 'Салбар тохируулаагүй байна',
                      ),
              ),
            ),
    );
  }
}