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
          iconTheme: IconThemeData(color: invoiceColor),
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Нэхэмжлэл дэлгэрэнгүй',
            style: TextStyle(
              color: invoiceColor,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: TabBar(
            indicatorColor: invoiceColor,
            labelColor: invoiceColor,
            unselectedLabelColor: grey2,
            isScrollable: true,
            tabs: [
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Үндсэн мэдээлэл',
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Төлөлтийн түүх',
                  ),
                ),
              ),
              Container(
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
            Text('1'),
            Text('1'),
          ],
        ),
      ),
    );
  }
}
