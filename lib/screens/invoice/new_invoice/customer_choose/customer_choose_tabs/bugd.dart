import 'package:dehub/components/supplier_card/supplier_card.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Bugd extends StatefulWidget {
  static const routeName = '/bugd';
  const Bugd({super.key});

  @override
  State<Bugd> createState() => _BugdState();
}

class _BugdState extends State<Bugd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SupplierCard(
              shoppingCard: false,
              onClick: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => buildSheet(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) => SalbarSongoh(),
      );
}
