import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/src/invoice_module/components/sector_card/sector_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SectorChoose extends StatefulWidget {
  static const routeName = '/SectorChoose';
  const SectorChoose({
    super.key,
  });

  @override
  State<SectorChoose> createState() => _SectorChooseState();
}

class _SectorChooseState extends State<SectorChoose> with AfterLayoutMixin {
  User user = User();
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
    invoice = await InvoiceApi().brach(user.currentBusiness!.id!, query);
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
      invoice = await InvoiceApi().brach(user.currentBusiness!.id!, value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    final source = Provider.of<InvoiceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: const CustomCloseButton(),
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Салбар сонгох',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SearchButton(
                    color: invoiceColor,
                    onChange: (query) {
                      setState(() {
                        onChange(query);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  isSubmit == false
                      ? invoice.rows!.isNotEmpty
                          ? Column(
                              children: invoice.rows!
                                  .map(
                                    (e) => SectorCard(
                                      data: e,
                                      onClick: () {
                                        source.sectorChoose(e);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : const NotFound(
                              module: "INVOICE",
                              labelText: "Мэдээлэл олдсонгүй",
                            )
                      : const Center(
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
