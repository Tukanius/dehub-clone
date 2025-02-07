import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/index1.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/pdf/pdf.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/send_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/new_invoice.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    super.key,
  });

  @override
  State<Harah> createState() => _HarahState();
}

class _HarahState extends State<Harah> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
        title: widget.invoice.refCode == null
            ? const Text(
                '-',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: white,
                ),
              )
            : Text(
                '${widget.invoice.refCode}',
                style: const TextStyle(
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
            const SizedBox(
              height: 30,
            ),
            Text(
              '${Utils().formatCurrency(widget.invoice.totalAmount.toString())} ₮',
              style: const TextStyle(
                color: invoiceColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            if (widget.isNewInvoice == false)
              Text(
                '${widget.invoice.senderBusiness?.profileName}',
                style: const TextStyle(
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            const Divider(
              indent: 25,
              endIndent: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user.currentBusiness?.type == "SUPPLIER" &&
                      widget.invoice.invoiceStatus == 'DRAFT' &&
                      Permission().check(user, "INV_LIST", boolean: 'isEdit'))
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                          NewInvoice.routeName,
                          arguments: NewInvoiceArguments(
                            data: widget.invoice,
                          ),
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
                        child: const Icon(
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
                    child: const Icon(
                      Icons.visibility_outlined,
                      color: white,
                    ),
                  ),
                  if (widget.isNewInvoice == false)
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: transparent,
                          isScrollControlled: true,
                          useSafeArea: true,
                          context: context,
                          builder: (context) => pdf(),
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
                            color: white),
                        child: const Icon(
                          Icons.picture_as_pdf_outlined,
                          color: grey3,
                        ),
                      ),
                    ),
                  // if (user.currentBusiness?.type == "SUPPLIER")
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
                      child: const Icon(
                        Icons.mail_outlined,
                        color: grey3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
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

  Widget pdf() => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 15, bottom: 10, left: 15),
                    color: transparent,
                    child: SvgPicture.asset(
                      'assets/svg/close.svg',
                      colorFilter:
                          const ColorFilter.mode(grey2, BlendMode.srcIn),
                      height: 20,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    INVOICEPDF(
                      lines: widget.invoice.lines!,
                      data: widget.invoice,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 0.5, color: grey3),
                          color: transparent,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/save1.svg',
                          colorFilter:
                              const ColorFilter.mode(grey3, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget sendSheet() => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) => SendPage(
          data: widget.invoice,
        ),
      );
}
