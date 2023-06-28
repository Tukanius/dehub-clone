import 'dart:async';

import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/sector_card/sector_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:lottie/lottie.dart';

class SalbarSongohArguments {
  ListenController partnerListenController;
  String id;
  SalbarSongohArguments({
    required this.partnerListenController,
    required this.id,
  });
}

class SalbarSongoh extends StatefulWidget {
  final ListenController partnerListenController;
  final String id;
  static const routeName = '/salbarsongoh';
  const SalbarSongoh({
    Key? key,
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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: invoiceColor,
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              'images/close.svg',
              height: 30,
            ),
          ),
        ),
        backgroundColor: invoiceColor,
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
                                            .partnerInvoiceChange(e);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
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
            ),
    );
  }
}
