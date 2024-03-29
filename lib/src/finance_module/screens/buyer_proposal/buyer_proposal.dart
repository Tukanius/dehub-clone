import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/finance_module/components/buyer_proposal_card/buyer_proposal_card.dart';
import 'package:dehub/src/finance_module/screens/set_limit_page/set_limit_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuyerProposal extends StatefulWidget {
  static const routeName = '/BuyerProposal';
  const BuyerProposal({super.key});

  @override
  State<BuyerProposal> createState() => _BuyerProposalState();
}

class _BuyerProposalState extends State<BuyerProposal> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result network = Result(rows: [], count: 0);
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  List<Finance> selected = [];
  User user = User();

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    network = await FinanceApi().networkList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 10000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: source.currentColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text(
          user.currentBusiness?.type == "SUPPLIER"
              ? 'Buyer-ийн санал'
              : 'Supplier-ийн санал',
          style: TextStyle(
            color: source.currentColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: selected.isNotEmpty
          ? Material(
              color: source.currentColor,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    SetLimitPage.routeName,
                    arguments: SetLimitPageArguments(data: selected),
                  );
                },
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Лимит тохируулах',
                    style: TextStyle(color: white),
                  ),
                ),
              ),
            )
          : null,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: source.currentColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              color: source.currentColor,
              onLoading:
                  network.count != network.rows!.length ? onLoading : null,
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: network.rows!
                      .map(
                        (data) => BuyerProposalCard(
                          selected: selected,
                          data: data,
                          onClick: () {
                            if (selected.contains(data)) {
                              setState(() {
                                selected.removeWhere(
                                    (element) => element.id == data.id);
                              });
                            } else {
                              setState(() {
                                selected.add(data);
                              });
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
