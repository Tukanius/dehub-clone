import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/sector_card/sector_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class SalbarSongohArguments {
  ListenController partnerListenController;
  Invoice data;
  String id;
  SalbarSongohArguments({
    required this.data,
    required this.partnerListenController,
    required this.id,
  });
}

class SalbarSongoh extends StatefulWidget {
  final ListenController partnerListenController;
  final String id;
  final Invoice data;
  static const routeName = '/salbarsongoh';
  const SalbarSongoh({
    Key? key,
    required this.data,
    required this.partnerListenController,
    required this.id,
  }) : super(key: key);

  @override
  State<SalbarSongoh> createState() => _SalbarSongohState();
}

class _SalbarSongohState extends State<SalbarSongoh> with AfterLayoutMixin {
  Timer? timer;
  Result invoice = Result(rows: [], count: 0);
  String query = '';
  bool isLoading = false;
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    invoice = await InvoiceApi().brach(widget.id, query);
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
      invoice = await InvoiceApi().brach(widget.id, value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Салбар сонгох',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        actions: [
          AddButton(
            color: Colors.orange,
            onClick: () {},
          ),
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SearchButton(
                    color: invoiceColor,
                    onChange: (_query) {
                      setState(() {
                        onChange(_query);
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  isSubmit == false
                      ? invoice.rows?.length != 0
                          ? Column(
                              children: invoice.rows!
                                  .map(
                                    (e) => SectorCard(
                                      data: e,
                                      onClick: () {
                                        widget.partnerListenController
                                            .partnerInvoiceChange(e.branch);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : NotFound(
                              module: "INVOICE",
                              labelText: 'Мэдээлэл олдсонгүй!',
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: invoiceColor,
                          ),
                        )
                ],
              ),
            ),
    );
  }
}
