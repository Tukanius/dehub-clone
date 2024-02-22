import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/rule/components/approval_rule_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RuleTab extends StatefulWidget {
  const RuleTab({super.key});

  @override
  State<RuleTab> createState() => _RuleTabState();
}

class _RuleTabState extends State<RuleTab> with AfterLayoutMixin {
  late RefreshController refreshController = RefreshController();
  bool isLoading = true;
  Result rules = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    rules = await UserApi()
        .approvalRule(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
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
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: userColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: userColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Хяналтын дүрэм',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  rules.rows!.isNotEmpty
                      ? Column(
                          children: [
                            Column(
                              children: rules.rows!
                                  .map(
                                    (e) => ApprovalRuleCard(
                                      data: e,
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
                          module: "USER",
                          labelText: 'Хоосон байна',
                        ),
                ],
              ),
            ),
          );
  }
}
