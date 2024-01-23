import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/tabs/basic_information_tab.dart';

class InvoiceDetailPageArguments {
  String id;
  InvoiceDetailPageArguments({
    required this.id,
  });
}

class InvoiceDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/InvoiceDetailPage';
  const InvoiceDetailPage({super.key, required this.id});

  @override
  State<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: invoiceColor),
          elevation: 0,
          backgroundColor: white,
          surfaceTintColor: white,
          title: const Text(
            'Нэхэмжлэл дэлгэрэнгүй',
            style: TextStyle(
              color: invoiceColor,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            indicatorColor: invoiceColor,
            labelColor: invoiceColor,
            unselectedLabelColor: grey2,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: const [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Үндсэн мэдээлэл',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Төлөлтийн түүх',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Тооцоо үлдэгдэл',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BasicInformationTab(
              id: widget.id,
            ),
            const Text('1'),
            const Text('1'),
          ],
        ),
      ),
    );
  }
}
