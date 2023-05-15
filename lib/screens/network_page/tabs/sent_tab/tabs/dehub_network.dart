import 'package:dehub/components/partner_cards/sent_card.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:flutter/material.dart';

class DehubNetwork extends StatefulWidget {
  const DehubNetwork({Key? key}) : super(key: key);

  @override
  _DehubNetworkState createState() => _DehubNetworkState();
}

class _DehubNetworkState extends State<DehubNetwork> {
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
            for (var i = 0; i < 10; i++)
              SentCard(
                onClick: () {
                  Navigator.of(context)
                      .pushNamed(SentInvitationDetail.routeName);
                },
              ),
          ],
        ),
      ),
    );
  }
}
