import 'package:dehub/src/partner_module/partner_page/tabs/businesses/tabs/buyers.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/businesses/tabs/suppliers.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Businesses extends StatefulWidget {
  const Businesses({super.key});

  @override
  State<Businesses> createState() => _BusinessesState();
}

class _BusinessesState extends State<Businesses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Material(
                color: white,
                child: TabBar(
                  labelColor: partnerColor,
                  unselectedLabelColor: grey2,
                  indicatorColor: partnerColor,
                  overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
                  tabs: const [
                    Tab(
                      text: 'Нийлүүлэгчид',
                    ),
                    Tab(
                      text: 'Худалдан авагчид',
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [
            Suppliers(),
            Buyers(),
          ],
        ),
      ),
    );
  }
}
