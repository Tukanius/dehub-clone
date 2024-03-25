import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/components/buyer_proposal_card/buyer_proposal_card.dart';
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: source.currentColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text(
          'Buyer-ийн санал',
          style: TextStyle(
            color: source.currentColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: network.rows!
              .map(
                (data) => BuyerProposalCard(data: data),
              )
              .toList(),
        ),
      ),
    );
  }
}
