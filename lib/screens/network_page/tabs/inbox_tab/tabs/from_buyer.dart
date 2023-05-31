import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:dehub/models/result.dart';
import 'package:flutter/material.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:after_layout/after_layout.dart';

class FromBuyer extends StatefulWidget {
  const FromBuyer({Key? key}) : super(key: key);

  @override
  _FromBuyerState createState() => _FromBuyerState();
}

class _FromBuyerState extends State<FromBuyer> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);
  bool isLoading = true;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  list(page, limit) async {
    Filter filter = Filter();
    Offset offset = Offset(page: page, limit: limit);
    print('================INVITATION=================');
    Result res = await BusinessApi()
        .list(ResultArguments(filter: filter, offset: offset));
    print('================INVITATION=================');
    setState(() {
      invitation = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: invitation.rows!
            .map(
              (item) => InboxCard(
                onClick: () {
                  Navigator.of(context).pushNamed(
                    InvitationDetailPage.routeName,
                    arguments: InvitationDetailPageArguments(
                      id: item.id,
                    ),
                  );
                },
                data: item,
              ),
            )
            .toList(),
      ),
    );
  }
}
