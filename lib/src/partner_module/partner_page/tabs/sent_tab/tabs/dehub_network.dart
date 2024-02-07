import 'package:dehub/components/partner_cards/invitation_card.dart';
import 'package:flutter/material.dart';

class DehubNetwork extends StatefulWidget {
  const DehubNetwork({super.key});

  @override
  DehubNetworkState createState() => DehubNetworkState();
}

class DehubNetworkState extends State<DehubNetwork> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            for (var i = 0; i < 10; i++)
              InvitationCard(
                index: i,
                startAnimation: true,
              ),
          ],
        ),
      ),
    );
  }
}
