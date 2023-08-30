import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/sector_card/sector_card.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:lottie/lottie.dart';

class SectorChooseArguments {
  ListenController sectorListenController;
  SectorChooseArguments({
    required this.sectorListenController,
  });
}

class SectorChoose extends StatefulWidget {
  final ListenController sectorListenController;

  static const routeName = '/SectorChoose';
  const SectorChoose({
    required this.sectorListenController,
    Key? key,
  }) : super(key: key);

  @override
  State<SectorChoose> createState() => _SectorChooseState();
}

class _SectorChooseState extends State<SectorChoose> with AfterLayoutMixin {
  Partner partner = Partner();
  int page = 1;
  int limit = 10;
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
    invoice =
        await InvoiceApi().brach(partner.user!.currentBusiness!.id!, query);
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
      invoice =
          await InvoiceApi().brach(partner.user!.currentBusiness!.id!, value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: CustomCloseButton(),
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
                                        widget.sectorListenController
                                            .sectorInvoiceChange(e);
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
