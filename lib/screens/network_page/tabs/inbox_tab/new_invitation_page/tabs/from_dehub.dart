import 'package:dehub/components/partner_cards/buyer_business_card.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:flutter/material.dart';

class FromDehubTab extends StatefulWidget {
  const FromDehubTab({super.key});

  @override
  State<FromDehubTab> createState() => _FromDehubTabState();
}

class _FromDehubTabState extends State<FromDehubTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Buyer бизнесүүд',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BuyerBusinessCard(
            onClick: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => buildSheet(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) => InvitationSentPage(),
      );
}
