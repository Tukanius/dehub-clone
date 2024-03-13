import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/partner_module/components/business_card/business_card.dart';
import 'package:dehub/src/partner_module/screens/update_business/update_business.dart';
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
  bool isLoading = true;
  Result business = Result(rows: [], count: 0);
  ListenController listenController = ListenController();

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
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit);
    });
    super.initState();
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
                          onClick: () {
                            Navigator.of(context).pushNamed(
                              UpdateBusiness.routeName,
                              arguments: UpdateBusinessArguments(
                                data: data,
                                listenController: listenController,
                              ),
                            );
                          },
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
