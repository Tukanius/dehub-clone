import 'package:dehub/components/supplier_card/supplier_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/src/entry_point/menu/shopping/shopping_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  static const routeName = '/All';
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++)
              SupplierCard(
                data: Invoice(),
                shoppingCard: true,
                onClick: () {
                  Navigator.of(context).pushNamed(ShoppingPage.routeName);
                },
              )
          ],
        ),
      ),
    );
  }

  // Widget buildSheet() => DraggableScrollableSheet(
  //       initialChildSize: 1,
  //       minChildSize: 0.5,
  //       maxChildSize: 1,
  //       builder: (context, scrollController) => SalbarSongoh(),
  //     );
}
