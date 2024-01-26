import 'dart:async';

import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/supplier_card/supplier_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class Bugd extends StatefulWidget {
  static const routeName = '/bugd';
  const Bugd({super.key});

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
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: backgroundColor,
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SearchButton(
                        color: invoiceColor,
                        onChange: (query) {
                          onChange(query);
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    isSubmit == false
                        ? invoice.rows!.isNotEmpty
                            ? Column(
                                children: invoice.rows!
                                    .map(
                                      (data) => SupplierCard(
                                        data: data,
                                        onClick: () {
                                          source.partnerChoose(data);
                                          Navigator.of(context).pushNamed(
                                            SalbarSongoh.routeName,
                                            arguments: SalbarSongohArguments(
                                              data: data,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : const NotFound(
                                module: "INVOICE",
                                labelText: "Мэдээлэл олдсонгүй!",
                              )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: invoiceColor,
                            ),
                          )
                  ],
                ),
              ));
  }
}
