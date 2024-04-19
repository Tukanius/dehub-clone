import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/businesses/tabs/buyers.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/businesses/tabs/suppliers.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Businesses extends StatefulWidget {
  const Businesses({super.key});

  @override
  State<Businesses> createState() => _BusinessesState();
}

class _BusinessesState extends State<Businesses> {
  Partner user = Partner();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;

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
        body: TabBarView(
          children: [
            Permission().partnerCheck(user, "PRT_SUPP")
                ? const Suppliers()
                : const NotFound(
                    module: "PARTNER",
                    labelText: 'Хандах эрх хүрэхгүй байна',
                  ),
            Permission().partnerCheck(user, "PRT_BUYER")
                ? const Buyers()
                : const NotFound(
                    module: "PARTNER",
                    labelText: 'Хандах эрх хүрэхгүй байна',
                  ),
          ],
        ),
      ),
    );
  }
}
