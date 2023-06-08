import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/partner_cards/sent_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class DehubNetwork extends StatefulWidget {
  const DehubNetwork({Key? key}) : super(key: key);

  @override
  _DehubNetworkState createState() => _DehubNetworkState();
}

class _DehubNetworkState extends State<DehubNetwork> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "NETWORK");
    var res = await BusinessApi().listSent(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      invitation = res;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Column(
              children: invitation.rows!
                  .map(
                    (e) => SentCard(
                      data: e,
                      onClick: () {
                        Navigator.of(context).pushNamed(
                          SentInvitationDetail.routeName,
                          arguments: SentInvitationDetailArguments(id: e.id),
                        );
                      },
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
