import 'dart:async';

import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/supplier_card/supplier_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:lottie/lottie.dart';

class Bugd extends StatefulWidget {
  static const routeName = '/bugd';
  const Bugd({
    Key? key,
  }) : super(key: key);

  @override
  State<Bugd> createState() => _BugdState();
}

class _BugdState extends State<Bugd> with AfterLayoutMixin {
  ListenController listenController = ListenController();
  Result invoice = Result(rows: [], count: 0);
  String query = "";
  Timer? timer;
  bool isLoading = false;
  bool isSubmit = false;

  @override
  void initState() {
    listenController.addListener(() async {
      invoice = await InvoiceApi().network(query);
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    invoice = await InvoiceApi().network(query);
    setState(() {
      isLoading = false;
    });
  }

  onChange(String value) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      invoice = await InvoiceApi().network(value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SearchButton(
                        color: invoiceColor,
                        onChange: (_query) {
                          onChange(_query);
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    isSubmit == false
                        ? invoice.rows?.length != 0
                            ? Column(
                                children: invoice.rows!
                                    .map(
                                      (e) => SupplierCard(
                                        data: e,
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            SalbarSongoh.routeName,
                                            arguments: SalbarSongohArguments(
                                              id: e.id,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : Column(
                                children: [
                                  Lottie.asset('images/not-found.json'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Мэдээлэл олдсонгүй!',
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )
                        : Center(
                            child: CircularProgressIndicator(
                              color: invoiceColor,
                            ),
                          )
                  ],
                ),
              ));
  }
}
