import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/businesses/components/business_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({super.key});

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result business = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "SUPPLIER");
    business = await PartnerApi()
        .business(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(color: partnerColor),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: business.rows!
                      .map(
                        (data) => BusinessCard(
                          data: data,
                          onClick: () {},
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
  }
}
