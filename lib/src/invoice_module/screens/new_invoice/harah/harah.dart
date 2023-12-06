import 'package:dehub/models/invoice.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/index1.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/pdf/pdf.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/send_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HarahArguments {
  Invoice invoice;
  bool isNewInvoice;
  HarahArguments({
    required this.isNewInvoice,
    required this.invoice,
  });
}

class Harah extends StatefulWidget {
  final Invoice invoice;
  final bool isNewInvoice;
  static const routeName = '/harah';
  const Harah({
    required this.isNewInvoice,
    required this.invoice,
    Key? key,
  }) : super(key: key);

  @override
  State<Harah> createState() => _HarahState();
}

class _HarahState extends State<Harah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: widget.invoice.refCode == null
            ? Text(
                '-',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: white,
                ),
              )
            : Text(
                '${widget.invoice.refCode}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: white,
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '${Utils().formatCurrency(widget.invoice.totalAmount.toString())} ₮',
              style: TextStyle(
                color: invoiceColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            widget.isNewInvoice == false
                ? Text(
                    '${widget.invoice.senderBusiness?.profileName}',
                    style: TextStyle(
                      fontSize: 16,
                      color: grey3,
                    ),
                  )
                : SizedBox(),
            Divider(
              indent: 25,
              endIndent: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: grey3, width: 0.5),
                        color: white,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: grey3,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: grey3, width: 0.5),
                        color: invoiceColor),
                    child: Icon(
                      Icons.visibility_outlined,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pdf();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: grey3, width: 0.5),
                          color: white),
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
                        color: grey3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: transparent,
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => sendSheet(),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: grey3, width: 0.5),
                        color: white,
                      ),
                      child: Icon(
                        Icons.mail_outlined,
                        color: grey3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
            ),
            Index1(
              isNewInvoice: widget.isNewInvoice,
              invoice: widget.invoice,
            )
          ],
        ),
      ),
    );
  }

  pdf() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: transparent,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          color: white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/close.svg',
                      colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              INVOICEPDF(lines: widget.invoice.lines!, data: widget.invoice),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 0.5, color: grey3),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: grey3,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 0.5, color: grey3),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/save1.svg',
                      colorFilter: ColorFilter.mode(grey3, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendSheet() => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) => SendPage(),
      );
}
